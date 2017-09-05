module Hrs
  class AppToken
    include ActiveModel::Model

    REQUIRED_ATTRIBUTES = {
        'password' => ['username', 'password']
    }

    attr_accessor :username, :password
    def initialize (attributes = {})
      @username = attributes[:username]
      @password = attributes[:password]
    end

    def token_json
      return nil if @token_object.nil?
      @token_object.is_a?(Array) ? @token_object.map(&:token_json) : @token_object.token_json
    end

    def generate_token
      @token_object = generate_token_for_user
    end

    private

    def generate_token_for_user
      return false unless valid?
      user = User.find_by_username(@username)
      user = user.authenticate(@password) if user
      unless user
        errors.add(:base, "authentication failed")
        return false
      end
      delete_token_for_user(user)
      token = user.user_tokens.build()
      token.save && token
    end

    def delete_token_for_user (user)
      user.user_tokens.delete_all
    end

  end

end
