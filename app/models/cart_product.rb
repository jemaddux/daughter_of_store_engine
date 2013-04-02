class CartProduct < ActiveRecord::Base
  attr_accessible :quantity,
                  :price,
                  :cart_id,
                  :product_id

  validates :quantity_is_one, presence: true

  def quantity_is_one
    Product.find(product_id).quantity >= 1
  end

  belongs_to :cart
  belongs_to :product
end