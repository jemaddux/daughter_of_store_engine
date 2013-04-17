class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text   :description
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :quantity
      t.boolean :featured
      t.timestamps
    end
  end
end
