class ShippingAddress < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :city, :phone, :state, :street, :zipcode
end
