require 'spec_helper'

describe "category" do

  let!(:customer) { Fabricate(:customer) }

  before(:each) do
    login_customer_post("admin", "admin")
  end

  let(:category) { Category.create(name: "Name", description: "Description") }

  it "should create a category" do 
    visit new_admin_category_path
    fill_in "category_name",        :with => "New category"
    fill_in "category_description", :with => "Some description"
    click_button "Create Category"
    expect( page ).to have_content "New category"
    expect( page ).to have_content "Some description"
  end

  it "edits the individual category" do 
    visit edit_admin_category_path(category)
    fill_in "category_name",        :with => "Some other category"
    fill_in "category_description", :with => "Some other description"
    click_button "Update Category"
    expect( page ).to have_content "Some other category"
    expect( page ).to have_content "Some other description"
  end
end