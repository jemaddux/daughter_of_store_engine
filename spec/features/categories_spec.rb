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

  # context "when given all the correct parameters" do
  #   it "should create a category" do 
  #     visit new_admin_category_path
  #     fill_in "category_name",        :with => "Test category"
  #     fill_in "category_description", :with => "Test description"
  #     click_button "Create Category"
  #     expect( page ).to have_content "Test category"
  #     expect( page ).to have_content "Test description"
  #   end

  #   it "should edit a category" do
  #     visit edit_admin_category_path(@category)
  #     fill_in "category_name", :with => "Test update"
  #     fill_in "category_description", :with => "Test description update"
  #     click_button "Update Category"
  #     expect( page ).to have_content "Test update"
  #     expect( page ).to have_content "Test description update"
  #   end
  # end

  # context "when given incorrect parameters" do
  #   it "should not create a category" do
  #     visit new_admin_category_path
  #     fill_in "category_name",        :with => "Test category"
  #     fill_in "category_description", :with => ""
  #     click_button "Create Category"
  #     expect( page ).to have_css('.field_with_errors')
  #   end

  #   it "should not edit a category" do
  #     visit edit_admin_category_path(@category)
  #     fill_in "category_name", :with => "Test update"
  #     fill_in "category_description", :with => ""
  #     click_button "Update Category"
  #     expect( page ).to have_css('.field_with_errors')
  #   end
  # end
end