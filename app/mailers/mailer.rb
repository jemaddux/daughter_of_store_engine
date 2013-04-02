class Mailer < ActionMailer::Base
  include SendGrid

  default from: "theforce@obiwear.com"

  def welcome_email(user)
    @customer = user
    @url      = "http://obiwear.com/login"
    mail(to: @customer.email, subject: "Welcome to Obiwear")
  end

  def order_confirmation(user, input_order)
    @customer = user
    @order    = input_order
    mail(to: @customer.email, subject: "Order Confirmation")
  end
end
