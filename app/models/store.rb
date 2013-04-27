class Store < ActiveRecord::Base
  attr_accessible :name, :path, :description, :status, :button_color,
    :button_color_hover, :background_color, :text_color, :text_font,
    :custom_css

  cattr_accessor :current_id

  has_many :orders
  has_many :pages

  has_many :background_images

  has_many :store_admins
  has_many :admins, through: :store_admins, source: :customer

  has_many :products
  has_many :categories

  has_many :store_stockers
  has_many :stockers, through: :store_stockers, source: :customer
  has_many :products
  has_many :categories

  validates :name, presence: true
  validates :path, presence: true
  validates_uniqueness_of :name
  validates_uniqueness_of :path

  def self.include_admin(admin_id, store_id)
    StoreAdmin.create(customer_id: admin_id, store_id: store_id)
  end

  def self.include_stocker(stocker_id, store_id)
    StoreStocker.create(customer_id: stocker_id, store_id: store_id)
  end

  def to_param
    path
  end

  def status_email
    admins.each do |admin|
      Mailer.store_status(admin, status).deliver
    end
  end


end
