Rails.application.routes.draw do
  root to: 'repositories#index'

  resources :repositories
  resources :reviews, only: [:create]

  get "/auth/signout", to: 'sessions#destroy', as: :sign_out
  get "/auth/github/callback", to: "sessions#create", as: :login
end
