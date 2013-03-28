class Product < ActiveRecord::Base
  attr_accessible :name, 
                  :description, 
                  :price, 
                  :quantity,
                  :featured,
                  :image,
                  :active

  validates :name,        presence: true, uniqueness: true
  validates :description, presence: true
  validates :price,       presence: true
  validates :quantity,    presence: true
  validates :featured,    inclusion: { in: [false, true] }
  validates :active,      inclusion: { in: [false, true] }
  # validates :category_id, presence: true
  has_many  :product_categories, dependent: :destroy
  has_many  :categories,         through: :categorizings

  has_attached_file :image, :styles => { :medium => "454x627>", :thumb => "182x304>" }, :default_url => "http://placehold.it/1000x1000&text=Thumbnail"

  scope :active, where(active: true)
end