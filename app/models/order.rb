class Order < ActiveRecord::Base
  attr_accessible :customer_id,
                  :status, 
                  :total,
                  :customer

  belongs_to  :customer

  has_many :order_products, dependent: :destroy
  has_many :products,       through:   :order_products
end