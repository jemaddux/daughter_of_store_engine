class CreditCard < ActiveRecord::Base
  attr_accessible :brand,
                  :cardholder_name,
                  :number,
                  :cvc,
                  :expiration_date,
                  :customer_id

  belongs_to :customer

  validates :brand,              presence: true
  validates :cardholder_name,    presence: true

  validates :number,   presence: true, length: {
      minimum: 16,
      maximum: 16,
      too_short: 'Must be 16 numbers long',
      too_long: 'Must be 16 numbers long'
  }

  validates :cvc, presence: true, length: {
      minimum: 3,
      maximum: 4,
      too_short: 'CVC codes range from 3 to 4 digits',
      too_long:  'CVC codes range from 3 to 4 digits'
  }

  validates :expiration_date, presence: true, length: {
      minimum: 4,
      maximum: 4,
      too_short: 'Format: mm/yy',
      too_long:  'Format: mm/yy'
  }
end
