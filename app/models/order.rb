class Order < ActiveRecord::Base
  attr_accessible :customer_id,
                  :status,
                  :total,
                  :customer,
                  :store_id


  default_scope { where(store_id: Store.current_id)  }

  belongs_to  :customer
  has_many :order_products


  def self.for_customer(customer,cart,store_id)
    order = customer.orders.create(status: "pending", store_id: store_id)
    order.create_order_products(cart)
    order.calculate_total
    order.save
    return order
  end

  def create_order_products(cart)
    cart.each do |id,quantity|
      product = Product.unscoped.find(id)
      self.order_products.create(
        :product_id       => product.id,
        :quantity         => quantity, 
        :price => product.price)
    end
  end

  def calculate_total
    self.total = self.order_products.map(&:subtotal).reduce(:+)
  end
end
