require 'spec_helper'

RSpec.describe Restaurant::Update do
  let! (:other_user) { User.create(username:'other_user',password:'other_user123',user_type:'owner') }
  let! (:owner_user) { User.create(username:'owner_user',password:'owmer_user123',user_type:'owner') }
  let! (:restaurant) { owner_user.restaurants.create(name:'Test Restaurant') }

  let (:pass_params) { { name: 'Test Hotel Updated'} }
  let (:fail_params) { { name: ''} }

  it 'fails for user who is not owner of restaurant' do
    result = Restaurant::Update.(pass_params.merge({id:restaurant.id,user_id:other_user.id}), "current_user" => other_user)
    expect(result).to be_failure
    expect(result['model']).to be_nil
  end

  it 'works for restaurant owner' do
    result = Restaurant::Update.(pass_params.merge({id:restaurant.id,user_id:owner_user.id}), "current_user" => owner_user)
    expect(result).to be_success
    expect(result['model']).to be_persisted
    expect(result['model'].name).to eq('Test Hotel Updated')
  end

  it 'fails with missing params' do
    result = Restaurant::Update.({}, "current_user" => owner_user)
    expect(result).to be_failure
    expect(result['model']).to be_nil
  end

  it 'fails with missing name field' do
    result = Restaurant::Update.(fail_params.merge({id:1,user_id:owner_user.id}), "current_user" => owner_user)
    expect(result).to be_failure
    expect(result['model']).to be_nil
  end


end