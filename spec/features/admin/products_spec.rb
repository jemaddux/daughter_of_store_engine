require 'spec_helper'

describe "products" do
  def valid_attributes
    { name:        "Awesome Product", 
      description: "This is my product description.",
      price:       124.99,
      quantity:    3,
      featured:    true,
      active:      true }
  end

  let!(:customer) { Fabricate(:customer) }

  before(:each) do
    login_customer_post("admin", "admin")
  end

  it "should create a product" do 
    visit new_admin_product_path
    fill_in "product_name",        :with => "New product"
    fill_in "product_description", :with => "Some description"
    fill_in "product_quantity",    :with => 7
    fill_in "product_price",       :with => 1234
    choose "product_featured_false"
    choose "product_active_true"
    click_button "Create Product"
    expect( page ).to have_content "Some description"
    expect( page ).to have_content "1,234"
  end

  it "edits the individual product" do 
    product = Product.create! valid_attributes
    visit edit_admin_product_path(product.id)
    fill_in "product_name",        :with => "Some other product"
    fill_in "product_description", :with => "Some other description"
    fill_in "product_price",       :with => 4321
    fill_in "product_quantity",    :with => 77
    choose "product_featured_false"
    click_button "Update Product"
    expect( page ).to have_content "Some other description"
    expect( page ).to have_content "$4,321.00"
  end
end