ActiveRecord::Schema.define(:version => 20130403190508) do

  create_table "admin_products", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cart_products", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.decimal  "price"
    t.integer  "quantity"
  end

  add_index "cart_products", ["cart_id"], :name => "index_cart_products_on_cart_id"
  add_index "cart_products", ["product_id"], :name => "index_cart_products_on_product_id"

  create_table "carts", :force => true do |t|
    t.integer  "customer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.decimal  "total"
  end

  add_index "carts", ["customer_id"], :name => "index_carts_on_customer_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "username",         :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "admin"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "order_products", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.decimal  "price"
    t.integer  "quantity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "order_products", ["order_id"], :name => "index_order_products_on_order_id"
  add_index "order_products", ["product_id"], :name => "index_order_products_on_product_id"

  create_table "orders", :force => true do |t|
    t.integer  "customer_id"
    t.string   "status"
    t.decimal  "total"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"

  create_table "product_categories", :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "product_categories", ["category_id"], :name => "index_categorizings_on_category_id"
  add_index "product_categories", ["product_id"], :name => "index_categorizings_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.integer  "quantity"
    t.boolean  "featured"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "active"
  end

  create_table "shipping_addresses", :force => true do |t|
    t.integer  "customer_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "shipping_addresses", ["customer_id"], :name => "index_shipping_addresses_on_customer_id"

end
