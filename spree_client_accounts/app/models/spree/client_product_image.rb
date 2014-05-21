module Spree
  
  
  class ClientProductImage < Spree::Image
    belongs_to :client_product, :foreign_key => :product_id
  end


end
