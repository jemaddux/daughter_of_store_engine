class ShippingAddress < ActiveRecord::Base
  attr_accessible :street,
                  :city,
                  :state,
                  :zipcode,
                  :phone,
                  :customer_id

  belongs_to :customer

  validates :street,  presence: true
  validates :city,    presence: true

  validates :state,   presence: true, length: { 
    minimum: 2,
    maximum: 2,
    too_short: "Enter a 2 character state code",
    too_long: "Enter a 2 character state code"     
  }

  validates :zipcode, presence: true, { 
    minimum: 5,
    maximum: 5,
    too_short: "Enter a 5 digit zipcode",
    too_long:  "Enter a 5 digit zipcode" 
  }

  validates :phone, presence: true, { 
    minimum: 10,
    maximum: 10,
    too_short: "Enter a 10 digit phone number",
    too_long:  "Enter a 10 digit phone number" 
  }
end
