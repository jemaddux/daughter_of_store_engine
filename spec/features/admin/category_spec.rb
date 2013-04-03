require 'spec_helper'

describe "category" do

  let!(:customer) { Fabricate(:customer) }

  before(:each) do
    login_customer_post("admin", "admin")
  end

  # it "should create a category" do 
  #   visit new_admin_category_path
  #   fill_in "category_name",        :with => "New category"
  #   fill_in "category_description", :with => "Some description"
  #   fill_in "category_quantity",    :with => 7
  #   fill_in "category_price",       :with => 1234
  #   choose "category_featured_false"
  #   choose "category_active_true"
  #   click_button "Create category"
  #   expect( page ).to have_content "Some description"
  #   expect( page ).to have_content "1,234"
  # end

  # it "edits the individual category" do 
  #   visit edit_admin_category_path(@category)
  #   fill_in "category_name",        :with => "Some other category"
  #   fill_in "category_description", :with => "Some other description"
  #   fill_in "category_price",       :with => 4321
  #   fill_in "category_quantity",    :with => 77
  #   choose "category_featured_false"
  #   click_button "Update Category"
  #   expect( page ).to have_content "Some other description"
  #   expect( page ).to have_content "4,321"
  # end
end