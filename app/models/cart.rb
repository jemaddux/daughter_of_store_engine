class Cart < ActiveRecord::Base
  attr_accessible :data
  belongs_to :customer
  store :data
end
