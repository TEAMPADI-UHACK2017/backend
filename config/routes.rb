Rails.application.routes.draw do
  #devise_for :tippers
  devise_for :merchants
  # devise_for :users, controllers: { sessions: 'users/sessions' }
  root to: 'tippers#index'
  #root to: "home#index"
  resources :merchants do
    collection do
      get '/unionbank_callback' => 'merchants#unionbank_callback'
    end
    get 'analytics', on: :member
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
    get 'get_token', on: :member
    post 'transfer', on: :member
  end

  resources :transactions
end
