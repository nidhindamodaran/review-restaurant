require 'spec_helper'

RSpec.describe Restaurant::Create do
  let! (:normal) { User.create(username:'normal_user',password:'normal_userr123')}
  let! (:owner) { User.create(username:'owner_user',password:'normal_user123',user_type:'owner') }
  let (:pass_params) { { name: 'Test Hotel'} }
  let (:fail_params) { { } }

  it 'fails for normal users' do
    result = Restaurant::Create.(pass_params.merge({user_id:normal.id}), "current_user" => normal)
    expect(result).to be_failure
    expect(result['model']).to be_nil
  end

  it 'works for restaurant owner' do
    result = Restaurant::Create.(pass_params.merge({user_id:owner.id}), "current_user" => owner)
    expect(result).to be_success
    expect(result['model']).to be_persisted
    expect(result['model'].name).to eq('Test Hotel')
  end

  it 'fails with missing params' do
    result = Restaurant::Create.(fail_params, "current_user" => owner)
    expect(result).to be_failure
    expect(result['model']).to be_nil
  end
end