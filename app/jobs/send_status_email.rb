class SendStatusEmail
  @queue = :email

  def self.perform(store_id)
    store = Store.find(store_id)
    store.status_email
  end
end
