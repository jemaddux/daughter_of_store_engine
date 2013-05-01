class Category < ActiveRecord::Base
  attr_accessible :name, :description, :store_id


  has_many  :product_categories
  has_many  :products, through: :product_categories

  validates :name, presence: true
  validates :store_id, presence: true
  validates_uniqueness_of :name, scope: :store_id


  def to_s
    name
  end
end
