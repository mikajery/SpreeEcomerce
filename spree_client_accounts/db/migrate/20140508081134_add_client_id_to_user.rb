class AddClientIdToUser < ActiveRecord::Migration
  
  
  def change
    
    add_column :spree_users, :client_id, :integer
    add_index :spree_users, :client_id
    
  end
end
