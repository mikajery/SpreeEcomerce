# This migration comes from spree_client_accounts (originally 20140508124852)
class AddAddressCompanyNoToClientAccounts < ActiveRecord::Migration
  def change
    
    add_column :spree_client_accounts, :tel1, :string, :limit => 20
    add_column :spree_client_accounts, :fax1, :string, :limit => 20
    add_column :spree_client_accounts, :email, :string

    add_column :spree_client_accounts, :contact_person, :string
    add_column :spree_client_accounts, :address1, :string, :limit => 500
    add_column :spree_client_accounts, :address2, :string, :limit => 500
    add_column :spree_client_accounts, :city, :string
    add_column :spree_client_accounts, :state, :string
    add_column :spree_client_accounts, :country, :string, :limit => 2
    
  end
end
