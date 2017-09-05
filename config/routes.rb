Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :app_tokens, only: [:create, :destroy]
    resources :restaurants do
      collection do
        post :add_favourite
        post :add_review
        post :add_deal
      end
    end
    resources :restaurant_deals
  end
end
