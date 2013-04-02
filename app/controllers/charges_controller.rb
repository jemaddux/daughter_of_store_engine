class ChargesController < ApplicationController
  def new
    @amount   = params[:amount]
    @customer = Customer.find(params[:customer])
    @order    = Order.create(
      customer_id: params[:customer], 
      status:      "pending",
      total:       params[:amount].to_i / 100 
      )

    session[:order_id] = @order.id
   
    @cart = Cart.find(session[:cart_id])
    @cart.cart_products_to_order_products(@order)
    @order.save
  end

  def create
    cart     = Cart.find(session[:cart_id])
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