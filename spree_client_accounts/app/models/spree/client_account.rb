module Spree
  
  
  class ClientAccount < ActiveRecord::Base
    validates_presence_of :name, :credit_limit, :credit_duration, :contact_person
    validates_uniqueness_of :name
    has_many :client_user, :foreign_key => :client_id
    
    def display_lifetime_value
      res = 0.00
      client_user.order("id asc").each do |user|
        if !user.display_lifetime_value.nil?
          res += user.display_lifetime_value.cents
        end
      end
      Spree::Money.new(res)
    end
    
    def order_count
      res = 0.00
      client_user.order("id asc").each do |user|
        if !user.order_count.nil?
          res += user.order_count
        end
      end
      res
    end
    
    def display_average_order_value
      res = 0.00
      client_user.order("id asc").each do |user|
        if !user.display_average_order_value.nil?
          res += user.display_average_order_value.cents
        end
      end
      Spree::Money.new(res)
    end
    
    def self.credit_duration_options
      #todo
    end
    
    def address_simple
      #res = address
    
      res = ""
      line2 = ""
      line2 = city if !city.blank?
      line2 += ", " if !state.blank? && !city.blank?
      line2 += state  if !state.blank?
    
      line3 = ""
      line3 = country_name if !country.blank?
    
      res += line2 if !line2.blank?
      res += "\n" if !line2.blank? && !line3.blank?
    
      res += line3 if !line3.blank?
    
      res
    end
  
    def address_full
      res = address
      line2 = ""
      line2 = city if !city.blank?
      line2 += ", " if !state.blank? && !city.blank?
      line2 += state  if !state.blank?

      line3 = ""
      line3 = country_name if !country.blank?

      res += line2 if !line2.blank?
      res += "\n" + line3 if !line3.blank?

      res
    end
  
    def country_name
      #::CountrySelect::COUNTRIES[country]
      if country.to_s.blank?
        nil
      else
        
        the_country = Spree::Country.find_by(iso: country.upcase)
        
        if the_country.nil?
          return country
        end
        the_country.name
      end
    
    end
  end


end
