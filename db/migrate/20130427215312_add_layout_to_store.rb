class AddLayoutToStore < ActiveRecord::Migration
  def change
    add_column :stores, :layout, :string, :default => "default"
  end
end
