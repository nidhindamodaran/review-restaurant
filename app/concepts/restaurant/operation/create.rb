class Restaurant::Create < Trailblazer::Operation
  step Policy::Guard( :authorize! )
  step Model(Restaurant, :new)
  step Contract::Build( constant: Restaurant::Contract::Create )
  step Contract::Validate()
  step Contract::Persist( )
  failure :notify!

  def authorize!(options, params:,current_user:, **)
    current_user.owner?
  end

  def notify!(options, **)
    options['model'] = nil
    options['errors'] = options['contract.default'] ?  options['contract.default'].errors.messages : 'Unauthorized User'
  end

end