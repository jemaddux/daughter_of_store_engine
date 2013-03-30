class Cart < ActiveRecord::Base
  belongs_to :customer
  has_many   :cart_products, dependent: :destroy
  has_many   :products,      through: :cart_products

  attr_accessible :total, :customer_id
end