require 'spec_helper'

describe "products" do

  before(:each) do
    Category.create(name: "Some category", description: "Some description")
    @product = Product.create(
      name: "Some product",
      description: "Some description",
      quantity: 7,
      price: 123,
      featured: false,
      active: true )
  end

  it "shows the products" do
    visit products_path
    expect( page ).to have_content "Some product"
  end

  it "shows the individual product" do
    visit product_path(@product)
    expect( page ).to have_content "Some description"
  end
end