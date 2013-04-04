require 'spec_helper'

describe Admin::CustomersController do
  def valid_attributes
    { 
      first_name:            "Chrissy",
      last_name:             "Knight",
      username:              "Username",
      email:                 "test@email.com",
      password:              "chrissy",
      password_confirmation: "chrissy",
      admin:                 "true"
    }
  end
  
  def valid_session
    { user_id: 1, order_id: 1 }
  end

  describe "GET index" do
    it "assigns all products as @products" do
      customer = Customer.create! valid_attributes
      get :index, {}, valid_session
      assigns(:customers).should eq([customer])
    end
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
      customer = Customer.create! valid_attributes
      get :show, {:id => customer.to_param}, valid_session
      assigns(:customer).should eq(customer)
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested customer" do
      customer = Customer.create! valid_attributes
      expect {
        delete :destroy, { id: customer.to_param }, valid_session
      }.to change(Customer, :count).by(-1)
    end

    it "redirects to the customers list" do
      customer = Customer.create! valid_attributes
      delete :destroy, { id: customer.to_param }, valid_session
      expect(response).to redirect_to(admin_customers_path)
    end
  end
end