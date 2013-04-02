require 'spec_helper'

describe Cart do

  before(:each) do
    @product = Product.create( name: "something", 
                              description: "something else", 
                              price: 123,
                              quantity: 1,
                              active: true,
                              featured: true )
  end

  def valid_attributes
    { customer_id:  2, 
      total:        123.99 }
  end

  it "adds items to the cart" do
    cart = Cart.create! valid_attributes
    cart.add(@product, 1)
    expect( cart.cart_products.count ).to eq 1
  end
end
