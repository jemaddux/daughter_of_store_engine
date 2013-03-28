class Category < ActiveRecord::Base
  attr_accessible :name, :description

  validates :name,        presence: true, uniqueness: true
  validates :description, presence: true

  has_many  :product_categories, dependent: :destroy
  has_many  :products,           through: :product_categories
end