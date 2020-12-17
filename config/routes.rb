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
      resources :merchants, except: [:index]

      get '/merchants/:id/items', to: "merchants/items#index"
    end
  end
end
