class Article < ActiveRecord::Base
  attr_accessible :body, :customer_id, :store_id, :title, :view_count

  validates :body, presence: true
  validates :title, presence: true
  validates :customer_id, presence: true
  validates :store_id, presence: true

  belongs_to :store
  belongs_to :customer

  def increase_view_count
    self.increment(:view_count,1)
  end
end
