class CreateClientAccounts < ActiveRecord::Migration
  def change
    create_table :spree_client_accounts do |t|
      t.string :name
      t.integer :credit_duration
      t.integer :credit_limit

      t.timestamps
    end
  end
end
