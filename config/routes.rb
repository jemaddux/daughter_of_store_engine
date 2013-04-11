StoreEngine::Application.routes.draw do
  resources :shipping_addresses
  resources :customers,          except: [:index]
  resources :customer_sessions,  only:   [:new, :create, :destroy]
  resources :cart_products,      only:   [:destroy]
  resources :shipping_addresses, except: [:index]

  match 'admin'  => 'admin/products#index'

  namespace :admin do
    root :to => 'admin/products#index'
    resources :categories
    resources :products
    resources :orders
    resources :customers, only: [:index, :show, :destroy]
  end

  resources :stores

  root to: 'stores#landing'

  match 'login'  => 'customer_sessions#new'
  match 'logout' => 'customer_sessions#destroy'
  match '/code'   => redirect('https://github.com/blairand/sonofstore_engine')

  scope '/:store_path' do
    match '/' => 'stores#show', as: 'home'
    resource :carts
    resources :categories,         only:   [:show, :index]
    resources :products,           only:   [:show, :index]
    resources :orders,             only:   [:show, :index]
    resources :charges,            only:   [:new, :create]
  end


end
