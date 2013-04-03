class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.references :customer
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone

      t.timestamps
    end
    add_index :shipping_addresses, :customer_id
  end
end
