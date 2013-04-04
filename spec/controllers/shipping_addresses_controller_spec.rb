require 'spec_helper'

describe ShippingAddressesController do
  def valid_attributes
    { street:      "Street Name", 
      city:        "Denver",
      state:       "Colorado",
      zipcode:     "20000",
      phone:       "202123456" }
  end

  let!(:customer) { Fabricate(:customer) }

  before(:each) do
    login_customer_post("admin", "admin")
  end

  def valid_session
    { user_id: 1 }
  end

  describe "GET show" do
    it "assigns the requested shipping_address as @shipping_address" do
      shipping_address = ShippingAddress.create! valid_attributes
      get :show, {:id => shipping_address.to_param}, valid_session
      assigns(:shipping_address).should eq(shipping_address)
    end
  end

  describe "GET new" do
    it "assigns a new shipping_address as @shipping_address" do
      get :new, {}, valid_session
      assigns(:shipping_address).should be_a_new(ShippingAddress)
    end
  end

  describe "GET edit" do
    it "assigns the requested shipping_address as @shipping_address" do
      shipping_address = ShippingAddress.create! valid_attributes
      get :edit, {:id => shipping_address.to_param}, valid_session
      assigns(:shipping_address).should eq(shipping_address)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ShippingAddress" do
        expect {
          post :create, {:shipping_address => valid_attributes}, valid_session
        }.to change(ShippingAddress, :count).by(1)
      end

      it "assigns a newly created shipping_address as @shipping_address" do
        post :create, {:shipping_address => valid_attributes}, valid_session
        assigns(:shipping_address).should be_a(ShippingAddress)
        assigns(:shipping_address).should be_persisted
      end

      it "redirects to the created shipping_address" do
        post :create, {:shipping_address => valid_attributes}, valid_session
        response.should redirect_to(ShippingAddress.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved shipping_address as @shipping_address" do
        ShippingAddress.any_instance.stub(:save).and_return(false)
        post :create, {:shipping_address => { "customer_id" => "invalid value" }}, valid_session
        assigns(:shipping_address).should be_a_new(ShippingAddress)
      end

      it "re-renders the 'new' template" do
        ShippingAddress.any_instance.stub(:save).and_return(false)
        post :create, {:shipping_address => { "customer_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested shipping_address" do
        shipping_address = ShippingAddress.create! valid_attributes
        ShippingAddress.any_instance.should_receive(:update_attributes).with({ "customer" => "" })
        put :update, {:id => shipping_address.to_param, :shipping_address => { "customer" => "" }}, valid_session
      end

      it "assigns the requested shipping_address as @shipping_address" do
        shipping_address = ShippingAddress.create! valid_attributes
        put :update, {:id => shipping_address.to_param, :shipping_address => valid_attributes}, valid_session
        assigns(:shipping_address).should eq(shipping_address)
      end

      it "redirects to the shipping_address" do
        shipping_address = ShippingAddress.create! valid_attributes
        put :update, {:id => shipping_address.to_param, :shipping_address => valid_attributes}, valid_session
        response.should redirect_to(shipping_address)
      end
    end

    describe "with invalid params" do
      it "assigns the shipping_address as @shipping_address" do
        shipping_address = ShippingAddress.create! valid_attributes
        ShippingAddress.any_instance.stub(:save).and_return(false)
        put :update, {:id => shipping_address.to_param, :shipping_address => { "customer_id" => "invalid value" }}, valid_session
        assigns(:shipping_address).should eq(shipping_address)
      end

      it "re-renders the 'edit' template" do
        shipping_address = ShippingAddress.create! valid_attributes
        ShippingAddress.any_instance.stub(:save).and_return(false)
        put :update, {:id => shipping_address.to_param, :shipping_address => { "customer_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested shipping_address" do
      shipping_address = ShippingAddress.create! valid_attributes
      expect {
        delete :destroy, {:id => shipping_address.to_param}, valid_session
      }.to change(ShippingAddress, :count).by(-1)
    end

    it "redirects to the shipping_addresses list" do
      shipping_address = ShippingAddress.create! valid_attributes
      delete :destroy, {:id => shipping_address.to_param}, valid_session
      response.should redirect_to(customer_path(customer.id))
    end
  end
end