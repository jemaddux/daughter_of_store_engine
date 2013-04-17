class RemoveUsernameFromCustomer < ActiveRecord::Migration
  remove_column :customers, :username
end
