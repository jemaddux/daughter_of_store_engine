class SendWelcomeEmail
  @queue = :email

  def self.perform(user_id)
    user = Customer.find(user_id)
    Mailer.welcome_email(user).deliver
  end

end

