Rails.application.routes.draw do
  resources :repositories
  resources :reviews, only: [:create]
  root to: 'repositories#index'
end
