class NewStoreAdminEmail
  @queue = :email

  def self.perform(user_id, store_id)
    user = Customer.find(user_id)
    store = Store.find(store_id)
    Mailer.new_store_admin(user,store).deliver
  end

end
