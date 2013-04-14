class AddDisplayNameToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :display_name, :string
  end
end
