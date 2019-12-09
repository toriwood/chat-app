Rails.application.routes.draw do

  root 'users#index'

  resources :conversations, only: [:index, :show, :update]

  resources :users, only: [:index]
end
