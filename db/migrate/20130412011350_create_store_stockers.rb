class CreateStoreStockers < ActiveRecord::Migration
  def change
    create_table :store_stockers do |t|
      t.references :customer
      t.references :store

      t.timestamps
    end
    add_index :store_stockers, :customer_id
    add_index :store_stockers, :store_id
  end
end
