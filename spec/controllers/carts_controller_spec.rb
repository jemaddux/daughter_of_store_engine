require 'spec_helper'

describe CartsController do

  def valid_attributes
    { customer_id:  2, 
      total:        123.99 }
  end

  def valid_session
    { id: 1 }
  end

  before(:each) do
    @product = Product.create(  name: "something", 
                                description: "something else", 
                                price: 123,
                                quantity: 1,
                                active: true,
                                featured: true )
  end

  describe "GET show" do
    it "assigns the requested cart as @cart" do
      cart = Cart.create!
      cart.add(@product, 1)
      get :show, { id: 1 }, { cart_id: 1 }
      assigns(:cart).should eq(cart)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      # it "updates the requested cart" do
      # end

      # it "assigns the requested cart as @cart" do
      #   cart = Cart.create! valid_attributes
      #   put :update, {:id => cart.to_param, :cart => valid_attributes}, valid_session
      #   assigns(:cart).should eq(cart)
      # end

      # it "redirects to the cart" do
      #   cart = Cart.create! valid_attributes
      #   put :update, {:id => cart.to_param, :cart => valid_attributes}, valid_session
      #   response.should redirect_to(cart)
      # end
    end

    describe "with invalid params" do
      # it "assigns the cart as @cart" do
      #   cart = Cart.create! valid_attributes
      #   # Trigger the behavior that occurs when invalid params are submitted
      #   Cart.any_instance.stub(:save).and_return(false)
      #   put :update, {:id => cart.to_param, :cart => { "customer" => "invalid value" }}, valid_session
      #   assigns(:cart).should eq(cart)
      # end

      # it "re-renders the 'edit' template" do
      #   cart = Cart.create! valid_attributes
      #   # Trigger the behavior that occurs when invalid params are submitted
      #   Cart.any_instance.stub(:save).and_return(false)
      #   put :update, {:id => cart.to_param, :cart => { "customer" => "invalid value" }}, valid_session
      #   response.should render_template("edit")
      # end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cart" do
      cart = Cart.create! valid_attributes
      expect {
        delete :destroy, {:id => cart.to_param}, valid_session
      }.to change(Cart, :count).by(-1)
    end

    # it "redirects to the carts list" do
    #   cart = Cart.create! valid_attributes
    #   delete :destroy, {:id => cart.to_param}, valid_session
    #   response.should redirect_to(carts_url)
    # end
  end

end
