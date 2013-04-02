class Cart < ActiveRecord::Base
  attr_accessible :total, :customer_id

  belongs_to :customer
  
  has_many   :cart_products, dependent: :destroy
  has_many   :products,      through: :cart_products

  def add(product, quantity)
    product_price = quantity * product.price 

    unless products.include?(product)
      products << product
    end

    cart_product = cart_products.find_by_product_id(product.id)
    cart_product.update_attributes(quantity: quantity, price: product_price)

    recalculate
  end

  def recalculate
    self.total = cart_products.collect{ |product| product.price }.reduce(0, :+)
  end
end