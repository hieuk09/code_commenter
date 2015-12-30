Rails.application.routes.draw do
  resources :reviews, only: [:create]
end
