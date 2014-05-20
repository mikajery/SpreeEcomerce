#require "spree_client_accounts/models/spree/client_account"
#require "ClientAccount"

class Spree::Admin::ClientUsersController < Spree::Admin::ResourceController
  rescue_from Spree::Core::DestroyWithOrdersError, :with => :user_destroy_with_orders_error
  before_action :set_client
  after_filter :sign_in_if_change_own_password, :only => :update

  # http://spreecommerce.com/blog/2010/11/02/json-hijacking-vulnerability/
  before_filter :check_json_authenticity, :only => :index
  before_filter :load_roles
  
  

  def index
    respond_with(@collection) do |format|
      format.html
      format.json { render :json => json_data }
    end
  end

  def show
    redirect_to edit_admin_client_user_path(@client_user)
  end

  def create
    if params[:client_user]
      roles = params[:client_user].delete("spree_role_ids")
    end

    @client_user = Spree::ClientUser.new(client_user_params)
    @client_user.client_id = session[:client_id]
    
    if @client_user.save

      if roles
        @client_user.spree_roles = roles.reject(&:blank?).collect{|r| Spree::Role.find(r)}
      end

      flash.now[:success] = Spree.t(:created_successfully)
      render :edit
    else
      render :new
    end
  end

  def update
    if params[:client_user]
      roles = params[:client_user].delete("spree_role_ids")
    end

    if @client_user.update_attributes(client_user_params)
      if roles
        @client_user.spree_roles = roles.reject(&:blank?).collect{|r| Spree::Role.find(r)}
      end
      flash.now[:success] = Spree.t(:account_updated)
    end

    render :edit
  end

  def addresses
    if request.put?
      if @client_user.update_attributes(client_user_params)
        flash.now[:success] = Spree.t(:account_updated)
      end

      render :addresses
    end
  end

  def orders
    params[:q] ||= {}
    @search = Spree::Order.ransack(params[:q].merge(user_id_eq: @client_user.id))
    @orders = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
  end

  def items
    params[:q] ||= {}
    @search = Spree::Order.includes(
      line_items: {
        variant: [:product, { option_values: :option_type }]
      }).ransack(params[:q].merge(user_id_eq: @client_user.id))
    @orders = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
  end

  def generate_api_key
    if @client_user.generate_spree_api_key!
      flash[:success] = Spree.t('api.key_generated')
    end
    redirect_to edit_admin_client_user_path(@client_user)
  end

  def clear_api_key
    if @client_user.clear_spree_api_key!
      flash[:success] = Spree.t('api.key_cleared')
    end
    redirect_to edit_admin_client_user_path(@client_user)
  end

  def model_class
    Rails.logger.info "model class:::::: #{Spree.user_class}"
    #Spree.user_class
    Spree::ClientUser
  end

  protected

    def collection
      return @collection if @collection.present?
      if request.xhr? && params[:q].present?
        @collection = Spree::ClientUser.includes(:bill_address, :ship_address)
                          .where("spree_users.email #{LIKE} :search
                                 OR (spree_addresses.firstname #{LIKE} :search AND spree_addresses.id = spree_users.bill_address_id)
                                 OR (spree_addresses.lastname  #{LIKE} :search AND spree_addresses.id = spree_users.bill_address_id)
                                 OR (spree_addresses.firstname #{LIKE} :search AND spree_addresses.id = spree_users.ship_address_id)
                                 OR (spree_addresses.lastname  #{LIKE} :search AND spree_addresses.id = spree_users.ship_address_id)",
                                { :search => "#{params[:q].strip}%" })
                          .limit(params[:limit] || 100)
      else
        @search = Spree::ClientUser.ransack(params[:q])
        @collection = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
      end
      
      @collection = @collection.where(:client_id=>session[:client_id])
      @client_users = @collection
    end

  private
    def client_user_params
      params.require(:client_user).permit(Spree::PermittedAttributes.user_attributes |
                                   [:spree_role_ids,
                                    ship_address_attributes: Spree::PermittedAttributes.address_attributes,
                                    bill_address_attributes: Spree::PermittedAttributes.address_attributes])
    end

    # handling raise from Spree::Admin::ResourceController#destroy
    def user_destroy_with_orders_error
      invoke_callbacks(:destroy, :fails)
      render :status => :forbidden, :text => Spree.t(:error_user_destroy_with_orders)
    end

    # Allow different formats of json data to suit different ajax calls
    def json_data
      json_format = params[:json_format] or 'default'
      case json_format
      when 'basic'
        collection.map { |u| { 'id' => u.id, 'name' => u.email } }.to_json
      else
        address_fields = [:firstname, :lastname, :address1, :address2, :city, :zipcode, :phone, :state_name, :state_id, :country_id]
        includes = { :only => address_fields , :include => { :state => { :only => :name }, :country => { :only => :name } } }

        collection.to_json(:only => [:id, :email], :include =>
                           { :bill_address => includes, :ship_address => includes })
      end
    end

    def sign_in_if_change_own_password
      if try_spree_current_user == @client_user && @client_user.password.present?
        sign_in(@client_user, :event => :authentication, :bypass => true)
      end
    end

    def load_roles
      @roles = Spree::Role.all
    end
    
    def set_client
      if params[:client_id].to_i > 0
        session[:client_id] = params[:client_id].to_i
      end
      @client = Spree::ClientAccount.find(session[:client_id])
    end
end
