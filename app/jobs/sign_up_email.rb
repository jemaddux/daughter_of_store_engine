class SignUpEmail
  @queue = :email

  def self.perform(admin_id, email)
    admin = Customer.find(admin_id)
    Mailer.sign_up(admin,email).deliver
  end

end
