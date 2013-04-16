class Mailer < ActionMailer::Base
  include SendGrid

  default from: "customerservice@sonofsam.com"

  def welcome_email(user)
    @customer = user
    mail(to: @customer.email, subject: "New Account Confirmation")
  end

  def order_confirmation(store, user, order)
    @customer = user
    @order    = order
    @store    = store
    @products = @order.products
    mail(
      to: @customer.email, 
      subject: "Order Confirmation", 
      from: "customerservice@#{store.path}.com")
  end

  def store_status(user, status)
    @customer = user
    @status = status
    mail(to: @customer.email, subject:"Store Activated")
  end

end
