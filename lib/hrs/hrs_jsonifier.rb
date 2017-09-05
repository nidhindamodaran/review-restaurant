module Hrs
  module HrsJsonifier
    def self.as_json restaurant
      if restaurant.errors.present?
        {success:false, :errors => person.errors.full_messages}
      else
        restaurant.as_json(:root => "root-attrs")
      end
    end
  end
end
