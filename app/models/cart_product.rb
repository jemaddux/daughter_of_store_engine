class CartProduct < ActiveRecord::Base
  attr_accessible :quantity,
                  :price

  validates :quantity_is_one, presence: true

  def quantity_is_one
    Product.find(product_id).quantity >= 1
  end

  belongs_to :cart
  belongs_to :product
end