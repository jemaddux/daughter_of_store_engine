class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :store_id
      t.integer :customer_id
      t.integer :view_count, default: 0

      t.timestamps
    end
    add_index :articles, :store_id
    add_index :articles, :customer_id
  end
end
