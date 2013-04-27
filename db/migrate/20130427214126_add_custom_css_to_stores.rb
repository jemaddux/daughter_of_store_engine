class AddCustomCssToStores < ActiveRecord::Migration
  def change
    add_column :stores, :custom_css, :string
  end
end
