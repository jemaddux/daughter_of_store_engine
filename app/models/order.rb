class Order < ActiveRecord::Base
  attr_accessible :customer_id,
                  :status,
                  :total,
                  :customer,
                  :store_id

  before_save :generate_token

  #default_scope { where(store_id: Store.current_id)  }

  belongs_to  :customer
  belongs_to  :store
  has_many :order_products


  def include_addresses(user)
    self.shipping_id = user.shipping_address.id
    self.billing_id = user.address.id
    self.save
  end


  def products
    order_products.map do |order_product|
      [order_product, Product.unscoped.find_by_id(order_product.product_id)]
    end
  end


  def self.for_customer(customer,cart,store_id)
    order = customer.orders.create(status: "pending", store_id: store_id)
    order.create_order_products(cart)
    order.calculate_total
    order.save
    return order
  end


  def create_order_products(cart)
    cart.each do |id,unit_quantity|
      product = Product.unscoped.find(id)
      product.decrement(:quantity, unit_quantity).save
      self.order_products.create(
        :product_id       => product.id,
        :quantity         => unit_quantity,
        :price => product.price)
    end
  end

  def calculate_total
    self.total = self.order_products.map(&:subtotal).reduce(:+)
  end

  protected

  def generate_token
    Store.find(self.store_id).touch
    self.url_token = loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless Order.unscoped.where(url_token: random_token).exists?
    end
  end
end
