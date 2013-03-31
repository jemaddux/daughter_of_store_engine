class ChargesController < ApplicationController
  def new
    @amount   = params[:amount]
    @customer = Customer.find(params[:customer])
  end

  def create
    cart     = Cart.find(session[:cart_id])
    @amount   = (cart.total * 100).to_i

    customer = Customer.find(session[:user_id])
    email    = customer.email

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

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end