
class Spree::Admin::ClientProductImagesController < Spree::Admin::ImagesController
  before_action :set_client
  before_action :on_update, :only => [:update]
  
  new_action.before :new_before
  update.before :update_before
  
  protected
  
  def location_after_destroy
    admin_client_product_images_url(@object)
  end

  def location_after_save
    admin_client_product_images_url(@object)
  end
          
  def set_client
    @client = Spree::ClientAccount.find(session[:client_id])
  end
  
  def new_before
    @image = @object
  end
  
  def update_before
    super
    @image = @object
  end
  
  def find_resource
    res = Spree::ClientProductImage.with_deleted.friendly.find(params[:id])
    #Rails.logger.info "resource: "+res.inspect
    @image = res
  end
  
  def model_class
    Spree::ClientProductImage
  end
  
  def on_update
    params[:image] = params[:client_product_image]
  end
  
  def permit_attributes
    res = params.require(:client_product_image).permit!
    res
  end
  
end
