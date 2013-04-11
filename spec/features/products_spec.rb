require 'spec_helper'

describe "products" do
  before(:each) do
    @store = Store.create(name: "Sample Store", path: "samplestore")
    @product  = Product.create(
      name: "Some product",
      description: "Product description",
      quantity: 7,
      price: 123,
      featured: false,
      active: true,
      store_id: 1)
  end

  it "shows the products index for a single store" do
    visit products_path(@store)
    expect( page ).to have_content "Some product"
  end

  it "shows the individual product for a single store" do
    visit product_path(@store, @product)
    expect( page ).to have_content "Product description"
  end
end