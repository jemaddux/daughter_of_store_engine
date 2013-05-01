require "spec_helper"

describe Category do
  name = "Valid Name"
  description = "Valid Description"
  store_id = 1

  describe "submitted from products#create" do 
    product_name = "Valid Name"
    product_description = "Valid Description"
    price = 123
    quantity = 123
    active = true
    valid_list = "valid, products, list"

    it "should be created" do 
      product = Product.create(name: product_name, description: product_description, store_id: store_id, price: price, quantity: quantity, active: active)
      product.categories_list = valid_list
      expect( Category.count ).to eq valid_list.split.count
    end

    it "should have the same store_id as the product.store_id" do 
      product = Product.create(name: product_name, description: product_description, store_id: store_id, price: price, quantity: quantity, active: active)
      product.categories_list = valid_list
      Category.all.each do |cat|
        expect( cat.store_id ).to eq product.store_id
      end
    end

    it "should have created the same amount of categories as submitted" do 
      product = Product.create(name: product_name, description: product_description, store_id: store_id, price: price, quantity: quantity, active: active)
      product.categories_list = valid_list
      expect( product.categories.count ).to eq valid_list.split.count
    end

    it "should all have the same name as they were submitted" do 
      product = Product.create(name: product_name, description: product_description, store_id: store_id, price: price, quantity: quantity, active: active)
      product.categories_list = valid_list
      expect( product.categories.map(&:name).sort ).to eq valid_list.split(", ").sort
    end

    it "should not duplicate if same name for the store exists" do
      product = Product.create(name: product_name, description: product_description, store_id: store_id, price: price, quantity: quantity, active: active)
      3.times do 
        product.categories_list = valid_list
      end
      expect( product.categories.count ).to eq valid_list.split.count
      expect( product.categories.map(&:name).sort ).to eq valid_list.split(", ").sort
    end

    it "should remove category associations if removed" do 
      product = Product.create(name: product_name, description: product_description, store_id: store_id, price: price, quantity: quantity, active: active)
      product.categories_list = valid_list
      expect( product.categories.count ).to eq valid_list.split.count
      expect( product.categories.map(&:name).sort ).to eq valid_list.split(", ").sort
      product.categories_list = ""
      expect( product.categories.count ).to eq "".split.count
      expect( product.categories.map(&:name).sort ).to eq "".split(", ").sort
    end

  end

  describe "with valid inputs" do 
    it "a new category should be created" do 
      category = Category.create(name: name, store_id: store_id)
      expect(category).to be_valid
    end
  end

  describe "with invalid inputs" do 
    it "should not be created without a name" do 
      category = Category.create(description: description, store_id: store_id)
      expect(category).to be_invalid
    end
    
    it "should not be created without a store_id" do 
      category = Category.create(name: name, description: description)
      expect(category).to be_invalid
    end
  end
end
