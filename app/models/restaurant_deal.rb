class RestaurantDeal < ApplicationRecord
  belongs_to :user
  serialize :deal, JSON
end
