require 'spec_helper'

describe ChargesController do

  let!(:customer) { Fabricate(:customer) }

  before(:each) do
    customer = Customer.create(         username: "something" )

    product = Product.create(           name: "something", 
                                        description: "something else", 
                                        price: 123,
                                        quantity: 1,
                                        active: true,
                                        featured: true )

    cart = Cart.create(                 total: 123 )
    
    cart_product = CartProduct.create(  cart_id: 1, 
                                        quantity: 1,
                                        product_id: 1,
                                        cart_id: 1 )
    login_customer_post("admin", "admin")
  end

  def valid_attributes
    { amount: 123,
      customer: 1,
      cart_id: 1 }
  end

  def valid_session
    { cart_id: 1,
      user_id: 1,
      order_id: 1 }
  end

  describe "new charge" do
    it "makes a new charge" do
      get :new, valid_attributes, valid_session
      expect( response.status ).to eq 200
    end
  end

  # describe "create charge" do
  #   it "creates a charge" do
  #     Order.create!
  #     post :create, valid_attributes, valid_session
  #     expect( response.status ).to eq 302
  #   end
  # end
end
