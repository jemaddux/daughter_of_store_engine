class AddBackgroundColorToStores < ActiveRecord::Migration
  def change
    add_column :stores, :background_color, :string
  end
end
