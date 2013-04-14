class AddAddressesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_id, :integer
    add_index :orders, :shipping_id
    add_column :orders, :billing_id, :integer
    add_index :orders, :billing_id
  end
end
