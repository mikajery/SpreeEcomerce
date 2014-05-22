class Spree::Admin::ClientAccountsController < Spree::Admin::ResourceController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  
  def index
    #authorize! :list, Spree::ClientAccount, session[:access_token]
    session[:return_to] = request.url
    respond_with(@collection)
  end
  
  def update
    authorize! :update, @object, session[:access_token]
    #Rails.logger.info "permitted: "+permitted_resource_params.inspect
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


  
  # GET /client_accounts/1
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
    Spree::ClientAccount.find(params[:id])
  end

  def set_client
    @client = find_resource()
  end
  
  def permit_attributes
    params.require(:client_account).permit(:name, :credit_duration, :credit_limit,
    :contact_person, :address1, :address2, :city, :state, :country,
    :tel1, :fax1, :email)#.permit!
  end
  
end
