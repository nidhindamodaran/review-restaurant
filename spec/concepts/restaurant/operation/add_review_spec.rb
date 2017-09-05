require 'spec_helper'

RSpec.describe Restaurant::AddReview do
  let! (:user) { User.create(username:'user',password:'user123') }
  let! (:other_user) { User.create(username:'other_user',password:'other_user123') }

  let! (:restaurant) { user.restaurants.create(name:'Test Restaurant') }

  let (:pass_params) { {id:restaurant.id,review:'Good'} }
  let (:fail_params) { { name: ''} }

  it 'works with review params' do
    result = Restaurant::AddReview.(pass_params,'review_params'=>{body:pass_params[:review],user_id:user.id}, "current_user" => user)
    expect(result).to be_success
    expect(result['model']).to be_persisted
  end

  it 'works with other users' do
    result = Restaurant::AddReview.(pass_params,'review_params'=>{body:pass_params[:review],user_id:other_user.id}, "current_user" => other_user)
    expect(result).to be_success
    expect(result['model']).to be_persisted
  end
  #
  it 'fails with params missing' do
    result = Restaurant::AddReview.(fail_params,'review_params'=>{body:fail_params[:review]}, "current_user" => other_user)
    expect(result).to be_failure
    expect(result['model']).to be_nil
  end


end