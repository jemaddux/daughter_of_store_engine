class ChargesController < ApplicationController
<<<<<<< HEAD
  before_filter :require_login
  skip_filter :scope_current_store, only: [:new, :create]

  def new
    @amount   = params[:amount]
    @customer = Customer.find(session[:user_id])
    @order    = Order.create(
      customer_id: params[:customer],
      status:      "pending",
      total:       params[:amount].to_i / 100
      )
=======

  def new
    #if logged_in?

      #check for shipping
      #if shipping
      #else
        #redirect to create shipping
      #end

    #else
      #ask if they want to login?
      #ask if they want to create account
      #offer guest checkout page
    #end




    # @customer = Customer.find(params[:customer])
    # @order    = Order.create(
      # customer_id: params[:customer],
      # status:      "pending",
      # total:       params[:amount].to_i / 100
      # )
    # session[:order_id] = @order.id
    # @cart = session[:shopping_cart][current_store.id]
    # @order.save
  end

  def create
    cart     = Cart.find(session[:cart_id])
    session[:cart_id] = nil

    @amount  = (cart.total * 100).to_i

    customer = Customer.find(session[:user_id])
    email    = customer.email
    order    = Order.find(session[:order_id])

    customer = Stripe::Customer.create(
      email: email,
      card:  params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      @amount,
      description: 'Rails Stripe customer',
      currency:    'usd'
      )

    order.update_attributes(status: "processed")

    Mailer.order_confirmation(customer, order).deliver

    cart.destroy

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
