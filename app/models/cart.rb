class Cart < ActiveRecord::Base
  belongs_to :customer
  has_many   :cart_products, dependent: :destroy
  has_many   :products,      through: :cart_products

  attr_accessible :total, :customer_id

  def add(product, quantity)
    quantity      = quantity
    product_price = quantity * product.price 

    unless products.include?(product)
      products << product
    end

    cart_product = cart_products.find_by_product_id(product.id)
    cart_product.update_attributes(quantity: quantity, price: product_price)

    recalculate
  end

  def recalculate
    cart_total = cart_products.collect{ |cart_product| cart_product.price }.reduce(0){ |sum, i| sum + i}
    self.total = cart_total
  end
end