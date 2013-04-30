class Page < ActiveRecord::Base
  attr_accessible :title, :body, :store_id, :slug

  belongs_to :stores

  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :slug

  def create_slug
    self.slug = self.title.parameterize
  end

  def to_param
    slug
  end
end
