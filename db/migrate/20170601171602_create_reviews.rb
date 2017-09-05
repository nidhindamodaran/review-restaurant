class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :restaurant
      t.references :user
      t.string :body
      t.timestamps
    end
  end
end
