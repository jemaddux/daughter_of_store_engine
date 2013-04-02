require 'spec_helper'

describe "products/_form" do
  before(:each) do
    @product = Product.new( name: "Some Product", 
                            description: "This is my product description.",
                            price:       123.99,
                            quantity:    3,
                            featured:    true,
                            active:      true )
    @cart_product = CartProduct.new(cart_id: 1, product_id: 1, price: 1, quantity: 1)
  end

  # it "renders the form product form" do
  #   render

  #   # Run the generator again with the --webrat flag if you want to use webrat matchers
  #   assert_select "form[action=?][method=?]", product_path(@product), "post" do
  #   end
  # end
end
