class ChangeCategorizingTableName < ActiveRecord::Migration
  def change
    rename_table :categorizings, :product_categories
  end
end
