class AddDisplayNameToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :display_name, :string, :precision => 8, :scale => 2
  end
end
