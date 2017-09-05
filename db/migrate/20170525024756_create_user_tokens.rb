class CreateUserTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :user_tokens do |t|
      t.references :user
      t.string :access_token
      t.timestamps
    end
  end
end
