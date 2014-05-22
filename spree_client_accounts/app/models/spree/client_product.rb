module Spree
  
  
  class ClientProduct < Spree::Product
    
    belongs_to :client_account, :foreign_key => :client_id
    
  end


end
