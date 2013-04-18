class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.references :customer
      t.string :brand
      t.string :cardholder_name
      t.integer :number
      t.integer :cvc
      t.integer :expiration_date

      t.timestamps
    end
    add_index :credit_cards, :customer_id
  end
end
