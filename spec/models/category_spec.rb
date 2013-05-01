require "spec_helper"

describe Category do
  name = "Valid Name"
  description = "Valid Description"
  store_id = 1

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
