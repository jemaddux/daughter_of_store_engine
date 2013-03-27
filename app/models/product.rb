class Product < ActiveRecord::Base
  attr_accessible :name, 
                  :description, 
                  :price, 
                  :quantity,
                  :featured,
                  :category_id,
                  :image,
                  :active

  validates :name,        presence: true, uniqueness: true
  validates :description, presence: true
  validates :price,       presence: true
  validates :quantity,    presence: true
  validates :active,      presence: true
  # validates :category_id, presence: true
  belongs_to :category

  attr_accessor :active

  has_attached_file :image, :styles => { :medium => "454x627>", :thumb => "182x304>" }, :default_url => "http://placehold.it/1000x1000&text=Thumbnail"
end