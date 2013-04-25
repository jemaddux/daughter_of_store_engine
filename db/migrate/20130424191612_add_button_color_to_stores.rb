class AddButtonColorToStores < ActiveRecord::Migration
  def change
    add_column :stores, :button_color, :string
  end
end
