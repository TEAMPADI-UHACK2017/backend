Rails.application.routes.draw do
  #devise_for :tippers
  devise_for :merchants
  # devise_for :users, controllers: { sessions: 'users/sessions' }
  root to: 'visitors#index'
  #root to: "home#index"
  resources :merchants do
    collection do
      get '/unionbank_callback' => 'merchants#unionbank_callback'
    end
  end
  resources :tipees do
    collection do
      get 'find'
    end
  end
  resources :tippers do
    collection do
      get 'find'
    end
  end


  resources :transactions
end
