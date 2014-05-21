
class Spree::Admin::ClientProductImagesController < Spree::Admin::ImagesController
  before_action :load_data
  before_action :on_update, :only => [:update]
  
  new_action.before :new_before
  create.before :set_viewable
  update.before :set_viewable
        
#   update.before :update_before
  protected
  
  def edit
    
  end
  
  def collection_url
    if @client.nil?
      load_data()
    end
    
    #Rails.logger.info "client: "+@client.inspect
    #Rails.logger.info "product: "+@product.inspect
    res = admin_client_account_client_product_client_product_images_url(@client, @product)
    Rails.logger.info "collection-url: "+res
    res
  end
  
  def admin_client_account_client_product_image_url(admin, client, product, image)
    edit_admin_client_account_client_product_client_product_image_url(client, product, image)
    
  end
  
  def object_url(image)
    admin_client_account_client_product_client_product_image_url(@client, @product, image)
  end
  
  def edit_object_url(image)
    edit_admin_client_account_client_product_client_product_image_url(@client, @product, image)
  end
  
  def location_after_destroy
    admin_client_account_client_product_client_product_images_url(@client, @product)
  end

  def location_after_save
    collection_url
    #admin_client_account_client_product_client_product_image_url(@client, @product, @object)
  end
  
  def load_data
    @client = Spree::ClientAccount.find(params[:client_account_id])
    @product = Spree::ClientProduct.with_deleted.friendly.find(params[:client_product_id])
    
    @variants = @product.variants.collect do |variant|
      [variant.sku_and_options_text, variant.id]
    end
    @variants.insert(0, [Spree.t(:all), @product.master.id])
  end
  
  def find_resource
    if @product.nil?
      load_data()
    end
    
    #notes: 
    # => variant_images uses Spree::Image which uses paper clip
    # => and store in assets table, with type = Spree::Image
    # => so we cannot use other table name for this
    #Rails.logger.info "finding: "+params[:id]
    #Rails.logger.info "after!!!!!: "+@product.variant_images.inspect
    #res = Spree::ClientProductImage.find(params[:id])
    res = @product.variant_images.find(params[:id])
    #res = Spree::ClientProductImage.find(params[:id])
    @image = res
    res
  end
  
  def new_before
    @image = @product.variant_images.new
  end
  
  def model_class
    Spree::Image
  end
  
  def on_update
    #params[:image]
  end
  
  def object_name
    "image"
  end
  
  def permit_attributes
    res = params.require(:image).permit!
    res
  end
  
end
