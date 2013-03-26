describe "products" do

  before(:each) do
    Category.create(name: "Some category", description: "Some description")
    @product = Product.create(
      name: "Some product",
      description: "Some description",
      quantity: 7,
      price: 123,
      featured: false,
      category_id: 1 )
  end

  it "shows the products" do
    visit products_path
    expect( page ).to have_content "Some product"
  end

  it "shows the individual product" do
    visit product_path(@product)
    expect( page ).to have_content "Some description"
  end

  it "should create a product" do 
    visit new_admin_product_path
    fill_in "product_name",        :with => "New product"
    fill_in "product_description", :with => "Some description"
    fill_in "product_quantity",    :with => 7
    fill_in "product_price",       :with => 1234
    choose "product_featured_false"
    click_button "Create Product"
    expect( page ).to have_content "Some description"
    expect( page ).to have_content "1234"
  end

  it "edits the individual product" do 
    visit edit_admin_product_path(@product)
    fill_in "product_name",        :with => "Some other product"
    fill_in "product_description", :with => "Some other description"
    fill_in "product_price",       :with => 4321
    fill_in "product_quantity",    :with => 77
    choose "product_featured_false"
    click_button "Update Product"
    expect( page ).to have_content "Some other description"
    expect( page ).to have_content "4321"
  end
end