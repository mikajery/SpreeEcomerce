
class Spree::Admin::ClientProductsController < Spree::Admin::ProductsController
  before_action :set_client
  
  new_action.before :new_before
  create.before :create_before
  
  def collection
    res = super
    res = res.where(:client_id => session[:client_id])
  end
  
  protected
  
  def location_after_save
    spree.edit_admin_client_product_url(@object)
  end
          
  def set_client
    if params[:client_id].to_i > 0
      session[:client_id] = params[:client_id].to_i
    end
    @client = Spree::ClientAccount.find(session[:client_id])
  end
  
  def create_before
    if !params[:client_product][:prototype_id].blank?
      @prototype = Spree::Prototype.find(params[:client_product][:prototype_id])
    end
    
    @object.client_id = session[:client_id]
  end
  
  def new_before
    Rails.logger.info "new before!!!!!"
    @product = @object
  end
  
  def find_resource
    res = super
    @product = res
  end
  
  def model_class
    Spree::ClientProduct
  end
  
  def permit_attributes
    params.require(:client_product).permit!
  end
  
end
