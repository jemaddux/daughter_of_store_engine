class Category < ActiveRecord::Base
  attr_accessible :name,
                  :description

  has_many  :product_categories
  has_many  :products, through: :product_categories
  
  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
