require 'spec_helper'

describe Category do
  let(:category) { Category.new(
      name:        "Some category", 
      description: "This is my category description.",
      )
    }

  context "when given all correct parameters" do
    it "should be valid" do
      expect(category).to be_valid
    end
  end
    
  context "when it does not have a name" do  
    it "should be invalid" do
      category.name = nil
      expect(category).to be_invalid
    end

    it "should have an error on name" do
      category.name = nil
      expect(category).to have(1).error_on(:name)
    end
  end

  context "when creating a category with the same name" do
    let(:category2) { Category.create(
        name:        "Some category", 
        description: "This is my category description.",
        )
      }

    it "should be invalid" do
      category.save
      expect(category2).to be_invalid
    end

    it "should have an error on name" do
      category.save
      expect(category2).to have(1).error_on(:name)
    end
  end
end
