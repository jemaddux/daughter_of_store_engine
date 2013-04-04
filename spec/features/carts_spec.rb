require 'spec_helper'

describe "carts" do
  before(:each) do
    @category = Category.create(name: "Some category", description: "Some description")
    @product  = @category.products.create(
      name: "Some product",
      description: "Some description",
      quantity: 7,
      price: 123,
      featured: false,
      active: true )
  end

  context "when the user is not logged in" do
    it "adds a product to the cart" do
      visit category_path(@category)
      expect( page ).to have_content "Some category"
      click_button "Add to Cart"
      expect( page ).to have_content "Some description"
    end

    it "redirects you to the login page when clicking checkout" do
      visit category_path(@category)
      expect( page ).to have_content "Some category"
      click_button "Add to Cart"
      expect( page ).to have_content "Some description"
      click_on "Checkout"
      expect( page ).to have_content "Login"
    end
  end
end