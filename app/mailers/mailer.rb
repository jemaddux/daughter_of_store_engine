class Mailer < ActionMailer::Base
  include SendGrid

  default from: "customerservice@sonofsam.com"

  def welcome_email(user)
    @customer = user
    mail(to: @customer.email, subject: "New Account Confirmation")
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

  def store_status(user, status)
    @customer = user
    @status = status
    mail(to: @customer.email, subject:"Store #{@status}")
  end

end
