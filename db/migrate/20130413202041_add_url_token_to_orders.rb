class AddUrlTokenToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :url_token, :string
  end
end
