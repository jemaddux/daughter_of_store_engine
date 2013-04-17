class SignUpEmail
  @queue = :email

  def self.perform(store.id, email)
    #user = Customer.find(user_id)
    #user not in DB, need to pass in "loose" email?
    store = Store.find(store_id)
    user = Customer.find(user_id)  #email
    Mailer.sign_up(store.id, email).deliver
  end

end
