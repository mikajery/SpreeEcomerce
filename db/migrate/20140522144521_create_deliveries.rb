class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :user_id
      t.string :description

      t.timestamps
    end
  end
end
