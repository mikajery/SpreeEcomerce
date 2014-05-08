module Spree
  
  
  class ClientAccount < ActiveRecord::Base
    validates_presence_of :name, :credit_limit, :credit_duration, :contact_person
    validates_uniqueness_of :name
    
    
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
        the_country = Country[country]
        the_country.translations[I18n.locale.to_s] || the_country.name
      end
    
    end
  end


end
