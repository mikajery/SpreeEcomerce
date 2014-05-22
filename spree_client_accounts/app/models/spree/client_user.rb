module Spree
  
  
  class ClientUser < Spree::User
    belongs_to :client_account, :foreign_key => :client_id
    
    def initialize(*params)
      super
      Rails.logger.info "yaaaa"
    end
    
  end


end
