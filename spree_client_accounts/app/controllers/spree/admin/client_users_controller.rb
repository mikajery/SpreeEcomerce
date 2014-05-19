#require "spree_client_accounts/models/spree/client_account"
#require "ClientAccount"

class Spree::Admin::ClientUsersController < Spree::Admin::UsersController
  before_action :set_client, [:show, :edit, :update, :destroy]
  
  def index
    authorize! :list, Spree::ClientUser, session[:access_token]
    
    #todo
    #@users = 
    session[:return_to] = request.url
    respond_with(@collection)
  end
  
  def update
    authorize! :update, @object, session[:access_token]
    #Rails.logger.info "object: "+@object.inspect
    invoke_callbacks(:update, :before)
    if @object.update_attributes(permitted_resource_params)
      Rails.logger.info "updated-object: "+@object.inspect
      invoke_callbacks(:update, :after)
      flash[:success] = flash_message_for(@object, :successfully_updated)
      respond_with(@object) do |format|
        format.html { redirect_to location_after_save }
        format.js   { render :layout => false }
      end
    else
      # Stops people submitting blank slugs, causing errors when they try to update the product again
      invoke_callbacks(:update, :fails)
      respond_with(@object)
    end
  end


  def show
    authorize! :read, @object, session[:access_token]
    session[:return_to] ||= request.referer
    redirect_to( :action => :edit )
  end
  

  private
  
  def collection
    return @collection if @collection.present?
    params[:q] ||= {}
    params[:q][:deleted_at_null] ||= "1"

    params[:q][:s] ||= "name asc"
    @collection = super
    # @search needs to be defined as this is passed to search_form_for
    @search = @collection.ransack(params[:q])
    @collection = @search.result.
          page(params[:page]).
          per(Spree::Config[:admin_products_per_page])

    @collection
  end

  def find_resource
    Spree::User.find(params[:id])
  end

  def set_user
    @user = find_resource()
  end
  
  def set_client
    if (params[:client_id].to_i > 0)
      session[:client_id] = params[:client_id].to_i
    end
    
    @client = Spree::ClientAccount.find(session[:client_id])
  end
  
  # def permit_attributes
#     params.require(:client_account).permit(:name, :credit_duration, :credit_limit,
#     :contact_person, :address1, :address2, :city, :state, :country,
#     :tel1, :fax1, :email)#.permit!
#   end
  
end
