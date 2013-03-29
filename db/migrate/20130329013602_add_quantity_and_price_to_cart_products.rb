class AddQuantityAndPriceToCartProducts < ActiveRecord::Migration
  def change
    change_table :cart_products do |t|
      t.decimal :price
      t.integer :quantity
    end
  end
end