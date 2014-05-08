module Spree
  
  class ClientAccount < BaseModel
    validates_presence_of :name, :credit_limit, :credit_duration
  
  
    def self.credit_duration_options
      #todo
    end
  end


end