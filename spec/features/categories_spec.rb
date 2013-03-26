describe "categories" do

  before(:each) do
    Category.create(name: "Some category", description: "Some description")
    @category = Category.create(name: "New category", description: "Some description")
  end

  it "shows the categories" do
    visit categories_path
    expect( page ).to have_content "Some category"
  end

  it "shows the individual category" do
    visit category_path(@category)
    expect( page ).to have_content "New category"
  end

  it "should create a product" do 
    visit new_admin_category_path
    fill_in "category_name",        :with => "Test category"
    fill_in "category_description", :with => "Test description"
    click_button "Create Category"
    expect( page ).to have_content "Test category"
    expect( page ).to have_content "Test description"
  end
end