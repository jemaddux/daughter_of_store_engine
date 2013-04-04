require 'spec_helper'

describe "categories" do
  before(:each) do
    Category.create(name: "Some category", description: "Cat desc").save
    @category = Category.find_by_name("Some category")
  end

  it "shows the categories" do
    visit categories_path
    expect( page ).to have_content "Some category"
  end

  it "shows the individual category" do
    visit category_path(@category)
    expect( page ).to have_content "Some category"
  end
end