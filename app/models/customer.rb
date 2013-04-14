class Customer < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_confirmation_of :password,
                            message: "Password should match confirmation.",
                            if: :password

  validates :username,   uniqueness: true
  validates :email,      presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name,  presence: true

  has_one  :cart
  has_one  :shipping_address
  has_many :orders

  has_many :addresses

end
