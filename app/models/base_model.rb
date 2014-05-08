
class BaseModel < ActiveRecord::Base
  after_initialize :init
  self.abstract_class = true
  after_validation :on_save
  before_save :before_save
  after_save :after_save
  after_create :after_create
  
  before_destroy :before_destroy
  after_destroy :after_destroy
  
  #override me
  def init
  end
  
  #override me
  def on_save
  end
  
  def last_changed
    @last_changed
  end
  
  def before_save()
    @last_changed = changed
    true
  end
  
  def after_save() 
    
  end
  
  def after_create()
    
  end
  
  def after_destroy()
    
  end
  
  def before_destroy() 
    
  end
  
  def get_field_label(field)
    field.gsub("_", " ").titleize
  end
  
  def get_changed_text

    updated = []
    Rails.logger.info "changed: #{self.last_changed.inspect}"
    self.last_changed.each do |field|
      name = get_field_label(field)

      updated << "#{name} updated to \"#{get_changed_field_value(field)}\""
    end
    
    updated
  end
  
  def get_changed_field_value(field)
    self[field]
  end
  
  
  def is_new?
    id.nil? || id.zero? || created_at_changed?
  end
  
  
  #return hash with selected keys
  def to_hash_with_keys(*args)
    res = {}
    args.each do |arg|
      if !respond_to? arg
        raise "Invalid field: #{arg}"
      end
      res[arg] = send(arg)
    end
    #select {|k,v| args.include?(k) }
    res
  end
  
end