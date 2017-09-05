module Api
  #Token AEEcvU7StGbM7AeMz42LdTEe
  class RestaurantsController < ApplicationController
    skip_before_filter  :verify_authenticity_token
    def create
      result = Restaurant::Create.(inject_params,'current_user'=>@current_user)
      if result.success?
        render json:{success:true, restaurant:result['model'].as_json}
      else
        render json:{success:false, errors:result['errors']}
      end
    end

    def update
      result = Restaurant::Update.(inject_params,'current_user'=>@current_user)
      if result.success?
        render json:{success:true, restaurant:result['model'].as_json}
      else
        render json:{success:false, errors:result['errors']}
      end
    end

    def destroy
      result = Restaurant::Delete.(params,'current_user'=>@current_user)
      if result.success?
        render json: {success:true, restaurant: result['model'].as_json}
      else
        render json:{success:false, errors:result['errors']}
      end
    end

    def add_favourite
      result = Restaurant::AddFavourite.(params,'current_user'=>@current_user)
      if result.success?
        render json: {success:true, restaurant: result['model'].as_json}
      else
        render json:{success:false}
      end
    end

    def add_review
      result = Restaurant::AddReview.(params, 'review_params'=>{body:params[:review],user_id:@current_user.id})
      if result.success?
        render json: {success:true, restaurant: result['model'].as_json}
      else
        render json:{success:false}
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
