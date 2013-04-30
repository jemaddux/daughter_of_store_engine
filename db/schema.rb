# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130428211138) do

  create_table "addresses", :force => true do |t|
    t.integer  "status"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "customer_id"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "store_id"
    t.integer  "customer_id"
    t.integer  "view_count",  :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "articles", ["customer_id"], :name => "index_articles_on_customer_id"
  add_index "articles", ["store_id"], :name => "index_articles_on_store_id"

  create_table "background_images", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "store_id"
  end

  add_index "background_images", ["store_id"], :name => "index_background_images_on_store_id"

  create_table "carts", :force => true do |t|
    t.integer  "customer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.decimal  "total"
    t.string   "data"
  end

  add_index "carts", ["customer_id"], :name => "index_carts_on_customer_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "store_id"
  end

  add_index "categories", ["store_id"], :name => "index_categories_on_store_id"

  create_table "credit_cards", :force => true do |t|
    t.integer  "customer_id"
    t.string   "brand"
    t.string   "cardholder_name"
    t.integer  "number"
    t.integer  "cvc"
    t.integer  "expiration_date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "credit_cards", ["customer_id"], :name => "index_credit_cards_on_customer_id"

  create_table "customers", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "admin"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "display_name"
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
    t.integer  "store_id"
    t.string   "url_token"
    t.integer  "shipping_id"
    t.integer  "billing_id"
  end

  add_index "orders", ["billing_id"], :name => "index_orders_on_billing_id"
  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"
  add_index "orders", ["shipping_id"], :name => "index_orders_on_shipping_id"
  add_index "orders", ["store_id"], :name => "index_orders_on_store_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "store_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.decimal  "price",              :precision => 8, :scale => 2
    t.integer  "quantity"
    t.boolean  "featured"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "active"
    t.string   "photo_url"
    t.integer  "store_id"
  end

  add_index "products", ["store_id"], :name => "index_products_on_store_id"

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

  create_table "store_admins", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "store_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "store_admins", ["customer_id"], :name => "index_store_admins_on_customer_id"
  add_index "store_admins", ["store_id"], :name => "index_store_admins_on_store_id"

  create_table "store_stockers", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "store_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "store_stockers", ["customer_id"], :name => "index_store_stockers_on_customer_id"
  add_index "store_stockers", ["store_id"], :name => "index_store_stockers_on_store_id"

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "description"
    t.string   "status",             :default => "pending"
    t.string   "button_color"
    t.string   "button_color_hover"
    t.string   "background_color"
    t.string   "text_color"
    t.string   "text_font"
    t.string   "custom_css"
    t.string   "layout",             :default => "default"
  end

end
