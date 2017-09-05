class User < ApplicationRecord
  has_many  :restaurants
  has_many  :user_tokens
  has_and_belongs_to_many  :favourite_restaurants, class_name: 'Restaurant'
  has_many  :restaurant_deals
  has_secure_password

  def owner?
    user_type == 'owner'
  end
end
