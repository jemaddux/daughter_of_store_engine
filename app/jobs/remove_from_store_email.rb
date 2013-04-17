class RemoveFromStoreEmail
  @queue = :email

  def self.perform(user_id, store_id)
    user = Customer.find(user_id)
    store = Store.find(store_id)
    Mailer.remove_from_store(user,store).deliver
  end

end
