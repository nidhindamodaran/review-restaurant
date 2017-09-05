module Api
  class AppTokensController <  ApplicationController
    skip_before_action :authenticate, only: :create
    skip_before_filter  :verify_authenticity_token

    def create
      app_token = AppToken.new(token_params)
      if app_token.generate_token
        render json: {succes: true, token: app_token.token_json}
      else
        render json: {succes: false, error: app_token.errors.full_messages}
      end
    end

    private

    def token_params
      params.permit(:username, :password)
    end
  end
end
