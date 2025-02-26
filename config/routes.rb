# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :weather_forecasts, path: 'forecasts', except: %i[index new create show edit update destroy] do
        collection do
          get :search
        end
      end
    end
  end
end
