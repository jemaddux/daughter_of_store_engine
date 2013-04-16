class Customer < ActiveRecord::Base
  authenticates_with_sorcery!

  after_create :welcome_email
  
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

  def store_admin?
    current_store.admins.include?(current_user)
  end

  def store_stocker?
    current_store.stockers.include?(current_user)    
  end

  def welcome_email
    Resque.enqueue(SendWelcomeEmail, self.id)
  end

end
