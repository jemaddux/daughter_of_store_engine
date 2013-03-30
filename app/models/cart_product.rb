class CartProduct < ActiveRecord::Base
  attr_accessible :quantity

  belongs_to :cart
  belongs_to :product
  # attr_accessible :title, :body
end
