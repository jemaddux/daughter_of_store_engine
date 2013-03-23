class Product < ActiveRecord::Base
  attr_accessible :name, 
                  :description, 
                  :price, 
                  :quantity,
                  :featured

  validates :name,        presence: true, uniqueness: true
  validates :description, presence: true
  validates :price,       presence: true
  validates :quantity,    presence: true
end