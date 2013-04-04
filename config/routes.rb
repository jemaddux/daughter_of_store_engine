StoreEngine::Application.routes.draw do
  resources :shipping_addresses

  resources :orders,             only:   [:show, :index]
  resources :carts,              only:   [:show, :update, :destroy]
  resources :categories,         only:   [:show, :index]
  resources :products,           only:   [:show, :index]
  resources :customers,          except: [:index]
  resources :customer_sessions,  only:   [:new, :create, :destroy]
  resources :charges,            only:   [:new, :create]
  resources :cart_products,      only:   [:destroy]
  resources :shipping_addresses, except: [:index]

  match 'login'  => 'customer_sessions#new'
  match 'logout' => 'customer_sessions#destroy'
  match 'admin'  => 'admin/products#index'
  match '/code'   => redirect('https://github.com/novohispano/store_engine')

  namespace :admin do
    resources :categories
    resources :products
    resources :orders
    resources :customers, only: [:index, :show, :destroy]
  end

  root to: 'products#index'
end