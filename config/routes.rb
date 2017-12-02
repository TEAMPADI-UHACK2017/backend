Rails.application.routes.draw do
  #devise_for :tippers
  devise_for :merchants
  # devise_for :users, controllers: { sessions: 'users/sessions' }
  root to: 'visitors#index'
  #root to: "home#index"
  resources :merchants
  resources :tipees
  resources :tippers
  resources :transactions
end
