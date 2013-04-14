class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :status
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone

      t.timestamps
    end
  end
end
