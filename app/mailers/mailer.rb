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
    mail(to: @customer.email, subject:"Store #{@status}")
  end

  def new_store_admin(store, user)
    @customer = user
    mail(to: @customer.email, subject:"You are now a Store Admin")
  end

  def sign_up(store, email)
    ####how do we do this when that user doesn't exist in the database?
    ####do we need to create a new table to store the email address we searched for?
    @customer = user
    mail(to: @customer.email, subject:"Please create an account")
  end

end
