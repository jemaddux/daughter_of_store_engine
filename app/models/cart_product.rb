class CartProduct < ActiveRecord::Base
  attr_accessible :quantity,
                  :price

  belongs_to :cart
  belongs_to :product
end