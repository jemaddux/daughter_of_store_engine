class AddTextColorToStores < ActiveRecord::Migration
  def change
    add_column :stores, :text_color, :string
  end
end
