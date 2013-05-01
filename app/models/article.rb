class Article < ActiveRecord::Base
  attr_accessible :body, :customer_id, :store_id, :title, :view_count

  validates :body, presence: true
  validates :title, presence: true
  validates :customer_id, presence: true
  validates :store_id, presence: true

  belongs_to :store
  belongs_to :customer

  def increase_view_count
    page_views = self.view_count
    self.view_count = page_views+1
    self.save
  end
end
