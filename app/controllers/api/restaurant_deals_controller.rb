module Api
  #Token AEEcvU7StGbM7AeMz42LdTEe
  class RestaurantDealsController < ApplicationController
    skip_before_filter  :verify_authenticity_token
    def create
      result = RestaurantDeal::Create.(inject_params,'current_user'=>@current_user)
      if result.success?
        render json:{success:true, deal:result['model'].as_json}
      else
        render json:{success:false, errors:result['errors']}
      end
    end

    private

    def inject_params
      par = params
      par.merge!({user_id:@current_user.id})
      return par
    end
  end
end
