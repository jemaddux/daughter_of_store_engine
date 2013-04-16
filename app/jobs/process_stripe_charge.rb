class ProcessStripeCharge
  @queue = :charges

  def self.perform(email,stripe_token,order_total)
    customer = Stripe::Customer.create(
      email: email,
      card:  stripe_token
      )

    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      order_total.to_i,
      description: 'Rails Stripe customer',
      currency:    'usd'
      )
  rescue Stripe::CardError => e
    flash[:error] = e.message
  end
end
