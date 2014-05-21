
class Spree::Admin::ClientProductsController < Spree::Admin::ProductsController
  before_action :set_client
  before_action :on_update, :only => [:update]
  
  helper_method :clone_object_url
  
  new_action.before :new_before
  create.before :create_before
  update.before :update_before
  
  def collection
    res = super
    res = res.where(:client_id => session[:client_account_id])
  end
  
  protected
  
  def location_after_save
    spree.edit_admin_client_product_url(@object)
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
    res = Spree::ClientProduct.with_deleted.friendly.find(params[:id])
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
