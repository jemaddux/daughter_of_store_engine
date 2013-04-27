class Page < ActiveRecord::Base
  attr_accessible :title, :body, :store_id

  belongs_to :stores

  validates_presence_of :title
  validates_presence_of :body
end
