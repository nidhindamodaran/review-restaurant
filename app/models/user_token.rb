class UserToken < ApplicationRecord
  belongs_to :user
  has_secure_token :access_token

  def token_json
    as_json(only: [:access_token])
  end
end
