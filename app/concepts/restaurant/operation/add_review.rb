class Restaurant::AddReview < Trailblazer::Operation
  step Model(Restaurant, :find_by)
  step :check_params
  failure :report_errors
  step :add!

  def check_params(options,params)
    params[:params][:review].present?
  end

  def add!(options,review_params:,model:, **)
    model.reviews.create(review_params)
  end

  def report_errors(options,model:,**)
    options['model'] = nil
    options['errors'] = 'body missing'
  end
end