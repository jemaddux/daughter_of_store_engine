class CartProduct < ActiveRecord::Base
  attr_accessible :quantity,
                  :price

  attr_reader     :product

  validates :cart_id,    presence: true
  validates :product_id, presence: true

  belongs_to :cart
  belongs_to :product

  delegate :name, to: product
end