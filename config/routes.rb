Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/:id/merchants', to: "merchants#show"
      end
      resources :items

      namespace :merchants do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/most_revenue', to: 'business_intelligence#most_revenue'
        get '/:id/revenue', to: 'business_intelligence#merchant_revenue'
        get '/most_items', to: "business_intelligence#most_items"
        get '/:id/items', to: "items#index"
      end
      resources :merchants

      get '/revenue', to: "merchants/business_intelligence#revenue_across_dates"
    end
  end
end
