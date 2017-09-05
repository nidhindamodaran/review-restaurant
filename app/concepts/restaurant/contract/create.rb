require "reform"

module Restaurant::Contract
  class Create < Reform::Form
    # include Dry

    property :name
    property :user_id

    validates :name, presence: true

    # validation do
    #   required(:user_id).filled
    #   required(:name).filled
    #   required(:name).maybe(min_size?: 2)
    # end
  end
end