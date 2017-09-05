class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant do |t|
      t.references  :user
      t.string  :name
      t.timestamps
    end
  end
end
