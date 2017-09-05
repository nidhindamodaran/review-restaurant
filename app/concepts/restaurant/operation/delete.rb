class Restaurant::Delete < Trailblazer::Operation
  step Policy::Guard( :authorize! )
  step Model(Restaurant, :find_by)
  step :delete!
  failure :notify!

  def delete!(options, model:, **)
    model.destroy
  end

  def authorize!(options, params:,current_user:, **)
    current_user.owner? && current_user.restaurant_ids.include?(params[:id])
  end

  def notify!(options, **)
    options['errors'] = options['contract.default'] ?  options['contract.default'].errors.messages : 'Unauthorized User or Record Not found'
  end
end