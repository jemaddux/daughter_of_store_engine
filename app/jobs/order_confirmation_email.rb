class OrderConfirmationEmail
  @queue = :email

  def self.perform(store_id, user_id, order_id)
    store = Store.find(store_id)
    user = Customer.find(user_id)
    order = Order.unscoped.find(order_id)
    Mailer.order_confirmation(store, user, order).deliver
  end
end
