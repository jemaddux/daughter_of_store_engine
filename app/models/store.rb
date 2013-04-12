class Store < ActiveRecord::Base
  attr_accessible :name, :path, :description
  cattr_accessor :current_id

  has_many :store_stockers
  has_many :store_admins

  has_many :customers, through: :store_admins
  has_many :customers, thorugh: :store_stockers

  def to_param
    path
  end
end
