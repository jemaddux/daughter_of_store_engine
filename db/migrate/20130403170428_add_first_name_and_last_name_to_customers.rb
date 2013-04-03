class AddFirstNameAndLastNameToCustomers < ActiveRecord::Migration
  def change
    change_table :customers do |t|
      t.string :first_name
      t.string :last_name
    end
  end
end
