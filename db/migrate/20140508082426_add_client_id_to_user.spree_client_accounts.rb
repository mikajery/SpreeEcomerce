# This migration comes from spree_client_accounts (originally 20140508081134)
class AddClientIdToUser < ActiveRecord::Migration
  
  
  def change
    
    add_column :spree_users, :client_id, :integer
    add_index :spree_users, :client_id
    
  end
end
