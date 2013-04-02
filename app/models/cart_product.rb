class CartProduct < ActiveRecord::Base
  attr_accessible :quantity,
                  :price

  attr_reader     :product

  validates :quantity,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :price,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :cart_id,    presence: true
  validates :product_id, presence: true

  belongs_to :cart
  belongs_to :product

  delegate :name, to: product
end