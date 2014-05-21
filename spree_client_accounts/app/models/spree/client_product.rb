module Spree
  
  
  class ClientProduct < Spree::Product
    
    belongs_to :client_account, :foreign_key => :client_id
    
    has_many :variant_images, -> { order(:position) }, source: :images, 
      through: :variants_including_master, :class_name => "Image"
    
  end


end
