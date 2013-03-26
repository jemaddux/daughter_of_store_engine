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

  xit "should create a product" do 
    visit new_admin_product_path
    fill_in "product_name",        :with => "Some product"
    fill_in "product_description", :with => "Some description"
    fill_in "product_quantity",    :with => 7
    fill_in "product_price",       :with => 123
    choose "product_featured_false"
    click_button "Create Product"
    expect( page ).to have_content "Some description"
    within(".hide-from-small") do 
      expect( page ).to have_content "123"
    end
  end
end