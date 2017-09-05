require "reform"

module RestaurantDeal::Contract
  class Create < Reform::Form

    property :deal
    property :restaurant_id
    property :user_id

    validates :deal, presence: true

  end
end