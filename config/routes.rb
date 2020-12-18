Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index]

      get '/items/find', to: "items/search#show"
      get '/items/find_all', to: "items/search#index"

      resources :items, except: [:index]

      get '/items/:id/merchants', to: "items/merchants#show"

      resources :merchants, only: [:index]

      get '/merchants/find', to: "merchants/search#show"
      get '/merchants/find_all', to: "merchants/search#index"

      get '/merchants/most_revenue', to: 'merchants/business_intelligence#most_revenue'
      get '/merchants/:id/revenue', to: 'merchants/business_intelligence#merchant_revenue'
      get '/merchants/most_items', to: "merchants/business_intelligence#most_items"

      resources :merchants, except: [:index]

      get '/merchants/:id/items', to: "merchants/items#index"

      get '/revenue', to: "merchants/business_intelligence#revenue_across_dates"
    end
  end
end
