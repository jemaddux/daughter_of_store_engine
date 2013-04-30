class Customer < ActiveRecord::Base
  authenticates_with_sorcery!

  after_create :welcome_email

  validates_confirmation_of :password,
                            message: "Password should match confirmation.",
                            if: :password

  validates :email,         presence: true, :uniqueness => { :case_sensitive => false }
  validates :first_name,    presence: true
  validates :last_name,     presence: true


  has_one  :cart
  has_one  :shipping_address
  has_one  :address
  has_one  :credit_card
  has_many :orders
  has_many :articles

  has_many :store_admins
  has_many :stores_with_admin_access, through: :store_admins, source: :store

  has_many :store_stockers
  has_many :stores_with_stocker_access, through: :store_stockers, source: :store

  def store_admin?(store)
    store.admins.include?(self)
  end

  def store_stocker?(store)
    store.stockers.include?(self)
  end

  def welcome_email
    Resque.enqueue(SendWelcomeEmail, self.id)
  end

end
