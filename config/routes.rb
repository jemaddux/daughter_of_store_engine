StoreEngine::Application.routes.draw do
  resources :orders,            only: [:show, :index]
  resources :carts,             only: [:show, :update, :destroy]
  resources :categories,        only: [:show, :index]
  resources :products,          only: [:show, :index]
  resources :customers
  resources :customer_sessions, only: [:new, :create, :destroy]
  resources :charges,           only: [:new, :create]
  resources :cart_products,     only: [:destroy]

  match 'login'  => 'customer_sessions#new'
  match 'logout' => 'customer_sessions#destroy'
  match 'admin'  => 'admin/products#index'

  namespace :admin do
    resources :categories
    resources :products
    resources :orders
    resources :customers
  end

  root to: 'products#index'
end