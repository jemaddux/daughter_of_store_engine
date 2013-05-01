require 'spec_helper'

describe Product do
  name = "Valid Name"
  description = "Valid Description"
  store_id = 1
  price = 123
  quantity = 123
  active = true

  describe "with valid inputs" do 
    it "a new product should be created" do 
      product = Product.create(name: name, description: description, store_id: store_id, price: price, quantity: quantity, active: active)
      expect(product).to be_valid
    end

    it "should categories that match" do 
      product = Product.create(name: name, description: description, store_id: store_id, price: price, quantity: quantity, active: active)
      product.categories_list= "valid, products"
      expect(product).to be_valid
      expect(Category.count).to eq 2
      Category.all.each do |cat|
        expect(cat.store_id).to eq store_id
      end
    end
  end

  describe "with invalid inputs" do 
    it "should not be created without a name" do 
      product = Product.create(description: description, store_id: store_id, price: price, quantity: quantity, active: active)
      expect(product).to be_invalid
    end
    
    it "should not be created without a description" do 
      product = Product.create(name: name, store_id: store_id, price: price, quantity: quantity, active: active)
      expect(product).to be_invalid
    end

    it "should not be created without a store_id" do 
      product = Product.create(name: name, description: description, price: price, quantity: quantity, active: active)
      expect(product).to be_invalid
    end

    it "should not be created without a price" do 
      product = Product.create(name: name, description: description, store_id: store_id, quantity: quantity, active: active)
      expect(product).to be_invalid
    end

    it "should not be created without a quantity" do 
      product = Product.create(name: name, description: description, store_id: store_id, price: price, active: active)
      expect(product).to be_invalid
    end

  end
end
