class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate
  rescue_from Exception, with: :handle_error

  include Hrs
  
  def authenticate
    @current_user = nil
    header = request.headers.fetch("HTTP_AUTHORIZATION")
    puts header
    if header && header.match(/Bearer token=([[:alnum:]]*);/)
      @current_user = UserToken.find_by_access_token($1).try(:user)
    end
    raise "User not found" unless @current_user
  end

  def handle_error (exception)
    render json: { success: false, error: exception.message , status: 500}
  end
end
