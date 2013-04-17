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

  default_scope { where(store_id: Store.current_id)  }

  validates :name,        presence: true
  validates :description, presence: true

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

  has_attached_file :image,
                    styles: { large: "454x627>", thumb: "182x304>" },
                    default_url: "http://placehold.it/457/627"

  if Rails.env.production?
    has_attached_file :image,
                      styles: { large: "454x627>", thumb: "182x304>" },
                      default_url: "http://placehold.it/457/627",
                      :storage => :s3,
                      :bucket => 'c3po_store_engine',
                      :path => ":attachment/:id/:style.:extension",
                      :s3_credentials => {
                          :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                      }
  else
    has_attached_file :image,
                      styles: { large: "454x627>", thumb: "182x304>" },
                      default_url: "http://placehold.it/457/627"
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
