class Page < ActiveRecord::Base
  attr_accessible :title, :body, :store_id

  belongs_to :stores
end
