require 'spec_helper'

describe Product do
  let(:product) { Product.new(
      name:        "Some Product", 
      description: "This is my product description.",
      price:       123.99,
      quantity:    3,
      featured:    true
      )
    }

  context "when given all correct parameters" do
    it "should be valid" do
      expect(product).to be_valid
    end
  end
    
  context "when it does not have a name" do  
    it "should be invalid" do
      product.name = nil
      expect(product).to be_invalid
    end

    it "should have an error on name" do
      product.name = nil
      expect(product).to have(1).error_on(:name)
    end
  end

  context "when it does not have a description" do 
    it "should be invalid" do
      product.description = nil
      expect(product).to be_invalid 
    end

    it "should have an error on description" do 
      product.description = nil
      expect(product).to have(1).error_on(:description)
    end
  end

  context "when it does not have a price" do 
    it "should be invalid" do
      product.price = nil
      expect(product).to be_invalid 
    end

    it "should have an error on price" do 
      product.price = nil
      expect(product).to have(1).error_on(:price)
    end
  end

  context "when it does not have a quantity" do 
    it "should be invalid" do
      product.quantity = nil
      expect(product).to be_invalid 
    end

    it "should have an error on quantity" do 
      product.quantity = nil
      expect(product).to have(1).error_on(:quantity)
    end
  end

  context "when creating a product with the same name" do
    let(:product2) { Product.create(
        name:        "Some Product", 
        description: "This is my product description.",
        price:       123.99,
        quantity:    3,
        featured:    true
        )
      }

    it "should be invalid" do
      product.save
      expect(product2).to be_invalid
    end

    it "should have an error on name" do
      product.save
      expect(product2).to have(1).error_on(:name)
    end
  end
end