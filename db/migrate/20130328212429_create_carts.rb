class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :customer

      t.timestamps
    end
    add_index :carts, :customer_id
  end
end
