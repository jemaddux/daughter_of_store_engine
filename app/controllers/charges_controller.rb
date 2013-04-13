class ChargesController < ApplicationController
  # skip_filter :scope_current_store, only: [:new, :create]
  before_filter :request_login, only: [:new]

  def checkout_options
    @customer = Customer.new
  end

  def create_guest
    if params[:username] && params[:password]
      username = params[:username]
      password = params[:password]
      login(username,password, remember_me = false)
    else
      username = params[:email]
      email = params[:email]
      password = SecureRandom.hex(4)
      password_confirmation = password
      first_name = params[:first_name]
      last_name = params[:last_name]
      
      customer = Customer.create!(
        :username => username, 
        :email => email, 
        :first_name => first_name, 
        :last_name => last_name, 
        :password => password, 
        :password_confirmation => password_confirmation)

      address = params[:shipping_address]
      address["customer_id"] = customer.id

      customer.create_shipping_address(address)

      auto_login(customer)
    end
    redirect_to new_charge_path(current_store)
  end

  def new
    session[:return_to_url] = request.url
    @shipping_address = ShippingAddress.new
    cart_products = session[:shopping_cart][current_store.id]
    @order = Order.for_customer(current_user, cart_products, current_store.id)
    @products = @order.products
    
    session[:order_id] = @order.id
  end

  def create
    session[:return_to_url] = nil
    order = Order.unscoped.find(session[:order_id])

    customer = Stripe::Customer.create(
      email: current_user.email,
      card:  params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      (order.total*100).to_i,
      description: 'Rails Stripe customer',
      currency:    'usd'
      )

    order.update_attributes(status: "processed")

    Mailer.order_confirmation(current_store, current_user, order).deliver

    current_user.cart.destroy
    redirect_to url_token_path(current_store, order.url_token)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
