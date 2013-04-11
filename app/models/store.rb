class Store < ActiveRecord::Base
  attr_accessible :name, :path, :description
  cattr_accessor :current_id

  #def self.current_id=(id)
  #  Thread.current[:store_path] = id
  #end
  #
  #def self.current_id
  #  Thread.current[:store_path]
  #end

  def to_param
    path
  end
end
