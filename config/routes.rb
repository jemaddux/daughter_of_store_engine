require 'resque/server'

StoreEngine::Application.routes.draw do

  mount Resque::Server.new, at: "/resque"

  resource :customers,           except: [:index]
  resources :addresses,          except: [:index]
  resources :shipping_addresses, except: [:index]
  resources :credit_cards,       except: [:index]
  get '/order_token/:url_token' => 'orders#unique_order_confirmation', as: 'url_token'
  resources :orders,             only:   [:show, :index]

  resources :customer_sessions,  only:   [:new, :create, :destroy]
  resources :cart_products,      only:   [:destroy]
  resources :shipping_addresses, except: [:index]

  namespace :admin do
    resources :stores, only: [:show, :destroy, :update, :index]
    resources :customers, only: [:index, :show, :destroy]
  end

  get '/account' => 'customers#show'
  get '/signup' => 'customers#new'
  get '/profile' => 'customers#show'

  resources :stores
  put '/stores/:id/status' => 'stores#change_status', :as => 'change_store_status'
  root to: 'stores#landing'

  match 'login'  => 'customer_sessions#new'
  match 'logout' => 'customer_sessions#destroy'
  match '/code'   => redirect('https://github.com/philbattos/daughter_of_store_engine')

  scope '/:store_path' do
    resources :background_images
    resources :pages

    put '/remove_store_admin' => 'store_admin/stores#remove_store_admin', :as => 'remove_store_admin'
    put '/add_store_admin' => 'store_admin/stores#add_store_admin', :as => 'add_store_admin'
    put '/remove_store_stocker' => 'store_admin/stores#remove_store_stocker', :as => 'remove_store_stocker'
    put '/add_store_stocker' => 'store_admin/stores#add_store_stocker', :as => 'add_store_stocker'
    put '/administer'  => 'admin/stores#administer', :as => 'administer'
    get '/admin' => 'store_admin/stores#show', as: 'store_admin'
    get '/admin/store/edit' => 'store_admin/stores#edit', as: 'store_admin_edit_store'
    put '/admin/store/edit' => 'store_admin/stores#update', as: 'store_admin_edit_store'

    get '/admin/products' => 'store_admin/products#index', as: 'store_admin_products'
    get '/admin/products/new' => 'store_admin/products#new', as: 'store_admin_new_product'
    post '/admin/products/new' => 'store_admin/products#create', as: 'store_admin_new_product'
    get '/admin/products/:id' => 'store_admin/products#show', as: 'store_admin_product'
    get '/admin/products/:id/edit' => 'store_admin/products#edit', as: 'store_admin_edit_product'
    put '/admin/products/:id/edit' => 'store_admin/products#update', as: 'store_admin_edit_product'
    delete '/admin/products/:id' => 'store_admin/products#destroy', as: 'store_admin_delete_product'

    get '/admin/orders' => 'store_admin/stores#orders', as: "admin_orders"

    scope "/admin" do
      scope :module => "store_admin" do
        resources :categories, as: "admin_categories"
      end
    end

    scope "/stock" do
      scope :module => "store_stocker" do
        resources :products, as: "stocker_products"
      end
    end

    match '/' => 'stores#show', as: 'home'
    get '/orders/:url_token' => 'orders#unique_order_confirmation', as: 'another_url_token'
    resource :carts
    resources :categories,         only:   [:show, :index]
    resources :charges,            only:   [:new, :create]
    resources :products,           only:   [:show, :index]
    get '/checkout_options' => 'charges#checkout_options'
    post '/create_guest' => 'charges#create_guest'

  end
end
