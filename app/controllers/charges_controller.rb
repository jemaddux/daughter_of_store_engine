class ChargesController < ApplicationController
  # skip_filter :scope_current_store, only: [:new, :create]
  before_filter :request_login, only: [:new]

  def new
    @customer = current_user
    cart_products = session[:shopping_cart][current_store.id]
    @order = Order.for_customer(current_user, cart_products, current_store.id)
    session[:order_id] = @order.id

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
