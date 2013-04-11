class AddDataToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :data, :string
  end
end
