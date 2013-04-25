class AddAttachmentPhotosToBackgroundImages < ActiveRecord::Migration
  def self.up
    change_table :background_images do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :background_images, :photo
  end
end
