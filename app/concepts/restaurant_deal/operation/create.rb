class RestaurantDeal::Create < Trailblazer::Operation
  step Policy::Guard( :authorize! )
  step Model(RestaurantDeal, :new)
  step Contract::Build( constant: RestaurantDeal::Contract::Create )
  step Contract::Validate()
  step Contract::Persist( )
  failure :notify!

  def authorize!(options, params:,current_user:, **)
    current_user.owner? && current_user.restaurant_ids.include?(params[:restaurant_id].to_i)
  end

  def notify!(options, **)
    options['model'] = nil
    options['errors'] = options['contract.default'] ?  options['contract.default'].errors.messages : 'Unauthorized User'
  end

end