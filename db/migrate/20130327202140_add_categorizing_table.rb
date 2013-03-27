class AddCategorizingTable < ActiveRecord::Migration
  def change
    create_table :categorizings do |t|
      t.references :product
      t.references :category
      t.timestamps
    end
    add_index :categorizings, :product_id
    add_index :categorizings, :category_id
  end
end
