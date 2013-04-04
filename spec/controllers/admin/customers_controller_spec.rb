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

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested customer" do
        customer = Customer.create! valid_attributes
        put :update, {id: 1, :customer => { "first_name" => "Kylie" }}, valid_session
        expect( customer.first_name ).to be "Kylie"
      end

      it "assigns the requested customer as @customer" do
        customer = Customer.create! valid_attributes
        put :update, {:id => customer.to_param, :customer => valid_attributes}, valid_session
        assigns(:customer).should eq(customer)
      end

      it "redirects to the customer" do
        customer = Customer.create! valid_attributes
        put :update, {:id => customer.to_param, :customer => valid_attributes}, valid_session
        response.should redirect_to(admin_customers_path)
      end
    end

    describe "with invalid params" do
      it "assigns the customer as @customer" do
        customer = Customer.create! valid_attributes
        customer.any_instance.stub(:save).and_return(false)
        put :update, {:id => customer.to_param, :customer => {  }}, valid_session
        assigns(:customer).should eq(customer)
      end

      it "re-renders the 'edit' template" do
        customer = Customer.create! valid_attributes
        customer.any_instance.stub(:save).and_return(false)
        put :update, {:id => customer.to_param, :customer => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested customer" do
      customer = Customer.create! valid_attributes
      expect {
        delete :destroy, {:id => customer.to_param}, valid_session
      }.to change(customer, :count).by(-1)
    end

    it "redirects to the customers list" do
      customer = Customer.create! valid_attributes
      delete :destroy, {:id => customer.to_param}, valid_session
      expect(response).to redirect_to(customers_path)
    end
  end
end