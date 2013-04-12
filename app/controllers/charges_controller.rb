class ChargesController < ApplicationController
  # skip_filter :scope_current_store, only: [:new, :create]
  before_filter :request_login, only: [:new]

  def checkout_options
    @customer = Customer.new
  end

  def create_guest
    username = params[:username]
    password = params[:password]
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    billing_street = params[:billing_street]
    billing_city = params[:billing_city]
    billing_state = params[:billing_state]
    billing_zip = params[:billing_zip]
    shipping_street = params[:shipping_street]
    shipping_city = params[:shipping_city]
    shipping_state = params[:shipping_state]
    shipping_zip = params[:shipping_zip]

    if username && password
      login(username,password, remember_me = false)
    else

      #create user with randomized password and password_confirmation
      #auto_login(user)
    end
    redirect_to new_charge_path(current_store)
  end

  def new
    cart_products = session[:shopping_cart][current_store.id]
    @order = Order.for_customer(current_user, cart_products, current_store.id)

    products = []
    @order.order_products.each do |order_product|
        products << Product.find(order_product.product_id)
    end
    @products = products
    session[:order_id] = @order.id
  end

  def create
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

    # Mailer.order_confirmation(customer, order).deliver

    current_user.cart.destroy

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
