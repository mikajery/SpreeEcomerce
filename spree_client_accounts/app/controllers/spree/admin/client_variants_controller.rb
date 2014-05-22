
class Spree::Admin::ClientVariantsController < Spree::Admin::VariantsController
  
  protected
  
  def object_url(variant)
    admin_client_account_client_product_client_variant_url(@client, @product, variant)
  end
  
  def edit_object_url(variant)
    edit_admin_client_account_client_product_client_variant_url(@client, @product, variant)
  end
  
  def new_object_url()
    new_admin_client_account_client_product_client_variant_url(@client, @product)
  end
  
  def admin_client_account_client_product_variants_path(client, product, variant)
    admin_client_account_client_product_client_variant_url(client, product, variant)
  end
  
  def location_after_destroy
    collection_url
  end

  def location_after_save
    collection_url
    #admin_client_account_client_product_client_product_image_url(@client, @product, @object)
  end
  
  def collection_url(*params)
    if @client.nil?
      load_client()
    end
    
    res = admin_client_account_client_product_client_variants_url(@client, @product, params)
    #Rails.logger.info "collection-url: "+res
    res
  end
  
  
  def load_client
    @client = Spree::ClientAccount.find(params[:client_account_id])
    @product = Spree::ClientProduct.with_deleted.friendly.find(params[:client_product_id])
    
  end
  
  
  def load_resource
    load_client()
    res = super
    if !member_action?
      @variants = res
    end
    res
  end
  
  def build_resource
    if parent_data.present?
      parent.send(controller_name).build
    else
      @product.variants.new
    end
  end
  
  
  def model_class
    Spree::Variant
  end
  
  def object_name
    "variant"
  end
  
  
end
