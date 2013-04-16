class SignUpEmail
  @queue = :email

  def self.perform(user_id)
    user = Customer.find(user_id)
    Mailer.sign_up(user).deliver
  end

end
