class Customer < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_confirmation_of :password, 
                            message: "Password should match confirmation.",
                            if: :password

  validates :username, presence: true, uniqueness: true
  validates :email,    presence: true, uniqueness: true

  has_one  :cart
  has_many :orders
end