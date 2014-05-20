class AddClientIdToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :client_id, :integer
    
    add_index :spree_products, :client_id
    
  end
end
