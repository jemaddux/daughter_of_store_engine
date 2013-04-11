class Cart < ActiveRecord::Base
  attr_accessible :data
  belongs_to :customer
  store :data

  # has_many   :cart_products, dependent: :destroy
  # has_many   :products,      through: :cart_products

  # def add(product, quantity)
  #   product_price = quantity * product.price

  #   unless products.include?(product)
  #     products << product
  #   end

  #   cart_product = cart_products.find_by_product_id(product.id)
  #   cart_product.update_attributes(quantity: quantity, price: product_price)

  #   recalculate
  # end

  # def recalculate
  #   self.total = cart_products.collect{ |product| product.price }.reduce(0, :+)
  # end

  # def cart_products_to_order_products(order)
  #   self.cart_products.each do |cart_product|
  #     order_product            = order.order_products.create
  #     order_product.product_id = cart_product.product_id
  #     order_product.price      = cart_product.price
  #     order_product.quantity   = cart_product.quantity
  #   end
  # end
end
