class AddStoreIdToBackgroundImages < ActiveRecord::Migration
  def change
    add_column :background_images, :store_id, :integer
    add_index :background_images, :store_id
  end
end
