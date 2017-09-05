class Restaurant::Update < Trailblazer::Operation
  step Policy::Guard( :authorize! )
  step Model(Restaurant, :find_by)
  step Contract::Build( constant: Restaurant::Contract::Create )
  step Contract::Validate( )
  step Contract::Persist()
  failure :notify!

  def authorize!(options,params:,current_user:, **)
    current_user.owner? && current_user.restaurant_ids.include?(params[:id].to_i)
  end

  def notify!(options, **)
    options['model'] = nil
    options['errors'] = options['contract.default'] ?  options['contract.default'].errors.messages : 'Unauthorized User or Record Not found'
  end
end