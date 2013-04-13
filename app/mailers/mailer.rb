class Mailer < ActionMailer::Base
  include SendGrid

  default from: "customerservice@sonofsam.com"

  def welcome_email(user)
    @customer = user
    @url      = "http://obiwear.com/login"
    mail(to: @customer.email, subject: "Welcome to Obiwear")
  end

  def order_confirmation(current_store, user, input_order)
    @customer = user
    @order    = input_order
    @store    = current_store
    @products = @order.products
    mail(
      to: @customer.email, 
      subject: "Order Confirmation", 
      from: "customerservice@#{current_store.path}.com")
  end
end
