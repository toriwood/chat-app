Rails.application.routes.draw do

  root 'conversations#index'

  resources :conversations, only: [:index, :show]
end
