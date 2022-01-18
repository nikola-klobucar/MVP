Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  root to: "products#index"

  resources :products

  resources :users, only: [:show]
  resources :order_items
  resource :carts, only: [:show]
  resources :orders, only: [:index, :update]
  resources :payments, only: [:new, :create]
end
