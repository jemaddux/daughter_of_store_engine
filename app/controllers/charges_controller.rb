class ChargesController < ApplicationController
  # skip_filter :scope_current_store, only: [:new, :create]
  before_filter :request_login, only: [:new]

  def checkout_options
    @customer = Customer.new
  end

  def create_guest
    if params[:email] && params[:password]
      email = params[:email]
      password = params[:password]
      login(email,password, remember_me = false)
    else
      email = params[:email]
      password = SecureRandom.hex(4)
      password_confirmation = password
      first_name = params[:first_name]
      last_name = params[:last_name]
      
      if customer = Customer.create(
        :email => email, 
        :first_name => first_name, 
        :last_name => last_name, 
        :password => password, 
        :password_confirmation => password_confirmation)
      else
        redirect_to :back, notice:"Sorry, that email has already been taken."
      end
      auto_login(customer)
    end
    redirect_to new_charge_path(current_store)
  end

  def new
    session[:return_to_url] = request.url
    @shipping_address = ShippingAddress.new
    @billing_address = Address.new
    cart_products = session[:shopping_cart][current_store.id]
    
    if session[:order_id]
      @order = Order.unscoped.find(session[:order_id])
    else
      @order = Order.for_customer(
        current_user, 
        cart_products, 
        current_store.id)
      session[:order_id] = @order.id
    end

    @products = @order.products
  end

  def create
    session[:return_to_url] = nil
    order = Order.unscoped.find(session[:order_id])
    order.include_addresses(current_user)

    Resque.enqueue(
      ProcessStripeCharge,
      current_user.email,
      params[:stripeToken],
      (order.total*100)
      )

    order.update_attributes(status: "processed")

    Resque.enqueue(
      OrderConfirmationEmail, 
      current_store.id, 
      current_user.id, 
      order.id)

    current_user.cart.destroy
    session[:shopping_cart].clear
    redirect_to url_token_path(current_store, order.url_token)
 
  end
end
