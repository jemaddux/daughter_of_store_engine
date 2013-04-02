class CartProduct < ActiveRecord::Base
  attr_accessible :quantity,
                  :price

  validates :cart_id,    presence: true
  validates :product_id, presence: true

  belongs_to :cart
  belongs_to :product
end