require 'spec_helper'

describe "categories" do
  before(:each) do
    @store = Store.create!(name: "Sample Store", path: "samplestore")
    Category.create!(name: "shoes", description: "omg shoes", store_id: @store.id)
    @product1  = Product.create(
    name: "Product1",
    description: "Product 1 description",
    quantity: 7,
    price: 123,
    featured: false,
    active: true,
    store_id: @store.id,
    categories_list: "shoes, food")
    @product2  = Product.create(
    name: "Product2",
    description: "Product 2 description",
    quantity: 10,
    price: 156,
    featured: false,
    active: false,
    store_id: @store.id,
    categories_list: "shoes, food")
    @category = Category.unscoped.find(1)
  end

  it "shows all the active products for an individual category" do
    visit category_path(@store, @category)
    expect( page ).to have_content "Product1"
    expect( page ).to_not have_content "Product2"
  end
end