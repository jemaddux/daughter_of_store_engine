require 'spec_helper'

describe ProductsController do

  let!(:customer) { Fabricate(:customer) }

  # before(:each) do
  #   login_customer_post("admin", "admin")
  # end

  def valid_attributes
    { name:        "Some Product", 
      description: "This is my product description.",
      price:       123.99,
      quantity:    3,
      featured:    true,
      active:      true }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all products as @products" do
      product = Product.create! valid_attributes
      get :index, {}, valid_attributes, valid_session
      assigns(:products).should eq([product])
    end
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :show, {:id => product.to_param}, valid_session
      assigns(:product).should eq(product)
    end
  end
end
