class Restaurant::Index < Trailblazer::Operation
  step Model(Restaurant, :find_by)
end