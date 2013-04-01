class ChargesController < ApplicationController
  def new
    @amount   = params[:amount]
    @customer = Customer.find(params[:customer])
    @order    = Order.create(customer_id: params[:customer], 
     status:      "pending",
     total:       params[:amount].to_i / 100, 
     )
    @cart     = Cart.find(session[:cart_id])

    @cart.cart_products.each do |cart_product|
      order_product            = @order.order_products.create
      order_product.product_id = cart_product.product_id
      order_product.price      = cart_product.price
      order_product.quantity   = cart_product.quantity
    end
  end

  def create
    cart     = Cart.find(session[:cart_id])
    @amount  = (cart.total * 100).to_i

    customer = Customer.find(session[:user_id])
    email    = customer.email
    order    = customer.orders.last

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

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end