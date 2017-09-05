require 'spec_helper'

RSpec.describe Restaurant::Delete do
  let! (:other_user) { User.create(username:'other_user',password:'other_user123',user_type:'owner') }
  let! (:owner_user) { User.create(username:'owner_user',password:'owmer_user123',user_type:'owner') }
  let! (:restaurant) { owner_user.restaurants.create(name:'Test Restaurant') }

  let (:pass_params) { { id:restaurant.id} }
  let (:fail_params) { { } }

  it 'fails for user who is not owner of restaurant' do
    result = Restaurant::Delete.(pass_params, "current_user" => other_user)
    expect(result).to be_failure
    expect(result['model']).to be_nil
  end

  it 'works for restaurant owner' do
    result = Restaurant::Delete.(pass_params, "current_user" => owner_user)
    expect(result).to be_success
    expect(result['model']).to be_destroyed
  end
  #
  it 'fails with missing id' do
    result = Restaurant::Update.(fail_params, "current_user" => owner_user)
    expect(result).to be_failure
    expect(result['model']).to be_nil
  end
  #

end