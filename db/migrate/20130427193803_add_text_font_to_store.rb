class AddTextFontToStore < ActiveRecord::Migration
  def change
    add_column :stores, :text_font, :string
  end
end
