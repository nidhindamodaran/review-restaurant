class CreateRestaurantDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_deals do |t|
      t.references  :user
      t.integer :restaurant_id
      t.text  :deal
      t.timestamps
    end
  end
end
