class NewStoreAdminEmail
  @queue = :email

  def self.perform(user_id)
    user = Customer.find(user_id)
    Mailer.new_store_admin(user).deliver
  end

end
