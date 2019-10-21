# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "api/v1/index#index"
  
  namespace :api do
    namespace :v1 do
      root to: "index#indexv1"
      resources :users, only: %i[create]
      post "login", to: "sessions#create", as: "login"
      delete "logout", to: "sessions#destroy", as: "logout"
    end
  end

  match "/400", to: "errors#bad_request", via: :all
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
