class Restaurant::AddFavourite < Trailblazer::Operation
  step Model(Restaurant, :find_by)
  step :add!

  def add!(options,model:,current_user:,**)
    current_user.favourite_restaurants << model
  end
end