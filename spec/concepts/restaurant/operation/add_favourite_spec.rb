require 'spec_helper'

RSpec.describe Restaurant::AddFavourite do
  let! (:user) { User.create(username:'user',password:'user123') }
  let! (:other_user) { User.create(username:'other_user',password:'other_user123') }

  let! (:restaurant) { user.restaurants.create(name:'Test Restaurant') }

  let (:pass_params) { {id:restaurant.id} }
  let (:fail_params) { {} }

  it 'works with pass params' do
    result = Restaurant::AddFavourite.(pass_params, "current_user" => user)
    expect(result).to be_success
    expect(result['model']).to be_persisted
  end

  it 'works with other users' do
    result = Restaurant::AddFavourite.(pass_params, "current_user" => other_user)
    expect(result).to be_success
    expect(result['model']).to be_persisted
  end
  # #
  it 'fails with params missing' do
    result = Restaurant::AddReview.(fail_params, "current_user" => other_user)
    expect(result).to be_failure
    expect(result['model']).to be_nil
  end


end