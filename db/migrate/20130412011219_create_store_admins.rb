class CreateStoreAdmins < ActiveRecord::Migration
  def change
    create_table :store_admins do |t|
      t.references :customer
      t.references :store

      t.timestamps
    end
    add_index :store_admins, :customer_id
    add_index :store_admins, :store_id
  end
end
