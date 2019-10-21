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
end
