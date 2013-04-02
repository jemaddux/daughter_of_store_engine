StoreEngine::Application.routes.draw do
  resources :orders,            :only => [:show, :index]
  resources :carts
  resources :categories,        :only => [:show, :index]
  resources :products,          :only => [:show, :index]
  resources :customers
  resources :customer_sessions, :only => [:new, :create, :destroy]
  resources :charges
  resources :cart_products

  match 'login'  => 'customer_sessions#new'
  match 'logout' => 'customer_sessions#destroy'

  namespace :admin do
    resources :categories
    resources :products
    resources :orders
  end

  root :to => 'products#index'

end