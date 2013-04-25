class Category < ActiveRecord::Base
  attr_accessible :name, :description, :store_id


  has_many  :product_categories
  has_many  :products, through: :product_categories

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :store_id

  #default_scope { where(store_id: Store.current_id) }

  def to_s
    name
  end
end
