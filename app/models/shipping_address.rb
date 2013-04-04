class ShippingAddress < ActiveRecord::Base
  attr_accessible :street,
                  :city,
                  :state,
                  :zipcode,
                  :phone,
                  :customer_id

  belongs_to :customer
end
