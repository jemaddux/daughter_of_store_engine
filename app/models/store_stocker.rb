class StoreStocker < ActiveRecord::Base
  attr_accessible :customer_id, :store_id

  belongs_to :customer
  belongs_to :store
end
