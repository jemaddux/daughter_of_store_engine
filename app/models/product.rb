class Product < ActiveRecord::Base
  attr_accessible :name,
                  :description,
                  :price,
                  :quantity,
                  :featured,
                  :image,
                  :active,
                  :categories_list,
                  :store_id,
                  :photo_url

  paginates_per 9
  max_paginates_per 9

  validates :name,        presence: true
  validates :description, presence: true
  validates :store_id, presence: true

  validates :price,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :quantity,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :active,      inclusion: { in: [false, true] }

  has_many  :product_categories
  has_many  :categories, through: :product_categories

  has_many  :cart_products,      dependent: :destroy
  has_many  :carts,              through:   :cart_products

  has_many  :order_products,     dependent: :destroy
  has_many  :orders,             through:   :order_products

  if Rails.env.production?
    has_attached_file :image,
                      styles: { large: '454x627>', thumb: '182x304>' },
                      default_url: 'http://placehold.it/600/600',
                      :storage => :s3,
                      :path => ':attachment/:id/:style.:extension',
                      :s3_credentials => {
                          :bucket => ENV['S3_BUCKET_NAME'],
                          :access_key_id => ENV['S3_ACCESS_KEY'],
                          :secret_access_key => ENV['S3_SECRET_KEY']
                      }
  else
    has_attached_file :image,
                      styles: { large: '454x627>', thumb: '182x304>' },
                      default_url: 'http://placehold.it/600/600'
  end

  def categories_list
    categories.join(", ")
  end

  def categories_list=(cats_string)
    cat_names = cats_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_cats = cat_names.map do  |name|
      Category.find_or_create_by_name_and_store_id(name, self.store_id)
    end
    self.categories = new_or_found_cats
  end

end
