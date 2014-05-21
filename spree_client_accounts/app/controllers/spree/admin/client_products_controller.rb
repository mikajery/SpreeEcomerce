
class Spree::Admin::ClientProductsController < Spree::Admin::ProductsController
  before_action :set_client
  before_action :on_update, :only => [:update]
  
  new_action.before :new_before
  create.before :create_before
  update.before :update_before
  
  def collection
    res = super
    res = res.where(:client_id => session[:client_account_id])
  end
  
  def clone
    find_resource
    super
  end
  
  protected
  
  def location_after_save
    spree.edit_admin_client_account_client_product_url(@client, @object)
  end
  
  def collection_url
    admin_client_account_client_products_url(@client)
  end
  
  def edit_admin_product_url(res)
    edit_admin_client_account_client_product_url(@client, res)
  end
  
  def clone_object_url(resource)
    #request.url(:action => :clone)
    Rails.logger.info resource.inspect
    admin_client_account_client_product_clone_url(@client, resource)
  end
          
  def set_client
    if params[:client_account_id].to_i > 0
      session[:client_account_id] = params[:client_account_id].to_i
    end
    @client = Spree::ClientAccount.find(session[:client_account_id])
  end
  
  def create_before
    if !params[:client_product][:prototype_id].blank?
      @prototype = Spree::Prototype.find(params[:client_product][:prototype_id])
    end
    
    @object.client_id = session[:client_account_id]
  end
  
  def new_before
    @product = @object
  end
  
  def update_before
    super
    @product = @object
  end
  
  def find_resource
    if (!params[:id].nil?)
      res = Spree::ClientProduct.with_deleted.friendly.find(params[:id])
    elsif !params[:client_product_id].nil?
      res = Spree::ClientProduct.with_deleted.friendly.find(params[:client_product_id])
    end
    #Rails.logger.info "resource: "+res.inspect
    @product = res
  end
  
  def model_class
    Spree::ClientProduct
  end
  
  def on_update
    params[:product] = params[:client_product]
  end
  
  def permit_attributes
    res = params.require(:client_product).permit!
    res
  end
  
end
