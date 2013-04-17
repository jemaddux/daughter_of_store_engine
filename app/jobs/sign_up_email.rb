class SignUpEmail
  @queue = :email

  def self.perform(store.id, email)
    #user = Customer.find(user_id)
    #user not in DB, need to pass in "loose" email?
    Mailer.sign_up(email).deliver
  end

end
