class AddButtonColorHoverToStores < ActiveRecord::Migration
  def change
    add_column :stores, :button_color_hover, :string
  end
end
