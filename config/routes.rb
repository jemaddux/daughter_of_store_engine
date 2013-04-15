StoreEngine::Application.routes.draw do

  resource :customers,          except: [:index]
  resources :addresses
  resources :shipping_addresses
  resources :orders,             only:   [:show, :index]
  resources :customer_sessions,  only:   [:new, :create, :destroy]
  resources :cart_products,      only:   [:destroy]
  resources :shipping_addresses, except: [:index]


  namespace :admin do
    resources :stores, only: [:show, :destroy, :update, :index]
    resources :customers, only: [:index, :show, :destroy]
  end


  # namespace :admin do
  #   resources :stores, only: [:show, :destroy, :update, :index]
  #   resources :categories
  #   resources :products
  #   resources :orders
  #   resources :customers, only: [:index, :show, :destroy]
  # end

  namespace :store_admin do
    resources :stores, only: [:index, :edit, :update, :destroy, :show]
  end

  get '/account' => 'customers#show'
  get '/signup' => 'customers#new'

  resources :stores
  put '/stores/:id/status' => 'stores#change_status', :as => 'change_store_status'
  root to: 'stores#landing'

  match 'login'  => 'customer_sessions#new'
  match 'logout' => 'customer_sessions#destroy'
  match '/code'   => redirect('https://github.com/blairand/sonofstore_engine')

  scope '/:store_path' do
    
    match '/' => 'stores#show', as: 'home'
    get '/orders/:url_token' => 'orders#unique_order_confirmation', as: 'url_token'
    resource :carts
    resources :categories,         only:   [:show, :index]
    resources :products,           only:   [:show, :index]
    resources :charges,            only:   [:new, :create]
    get '/checkout_options' => 'charges#checkout_options'
    post '/create_guest' => 'charges#create_guest'

  end


end
