require 'spec_helper'

describe CustomersController do
  let (:customer ) { Customer.create( valid_attributes )}

  def valid_attributes
    { 
      first_name:            "John",
      last_name:             "Doe",
      username:              "MyString",
      email:                 "123@bigwalkway.com",
      password:              "jorgesporno",
      password_confirmation: "jorgesporno"
    }
  end

  before(:each) do
    login_customer_post("MyString", "jorgesporno")
  end

  def valid_session
    { user_id: 1 }
  end

  describe "GET show" do
    it "assigns the requested customer as @customer" do
      get :show, {:id => customer.to_param}, valid_session
      assigns(:customer).should eq(customer)
    end
  end

  describe "GET new" do
    it "assigns a new customer as @customer" do
      get :new, {}, valid_session
      assigns(:customer).should be_a_new(Customer)
    end
  end

  describe "GET edit" do
    it "assigns the requested customer as @customer" do
      get :edit, {:id => customer.to_param}, valid_session
      assigns(:customer).should eq(customer)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Customer" do
        expect {
          post :create, {:customer => valid_attributes}, valid_session
        }.to change(Customer, :count).by(1)
      end

      it "assigns a newly created customer as @customer" do
        post :create, {:customer => valid_attributes}, valid_session
        assigns(:customer).should be_a(Customer)
        assigns(:customer).should be_persisted
      end

      it "redirects to the created customer" do
        post :create, {:customer => valid_attributes}, valid_session
        response.should redirect_to(Customer.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved customer as @customer" do
        Customer.any_instance.stub(:save).and_return(false)
        post :create, {:customer => { "username" => "invalid value" }}, valid_session
        assigns(:customer).should be_a_new(Customer)
      end

      it "re-renders the 'new' template" do
        Customer.any_instance.stub(:save).and_return(false)
        post :create, {:customer => { "username" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested customer" do
        Customer.any_instance.should_receive(:update_attributes).with({ "username" => "MyString" })
        put :update, {:id => customer.to_param, :customer => { "username" => "MyString" }}, valid_session
      end

      it "assigns the requested customer as @customer" do
        put :update, {:id => customer.to_param, :customer => valid_attributes}, valid_session
        assigns(:customer).should eq(customer)
      end

      it "redirects to the customer" do
        put :update, {:id => customer.to_param, :customer => valid_attributes}, valid_session
        response.should redirect_to(customer)
      end
    end

    describe "with invalid params" do
      it "assigns the customer as @customer" do
        customer = Customer.create! valid_attributes
        Customer.any_instance.stub(:save).and_return(false)
        put :update, {:id => customer.to_param, :customer => { "username" => "invalid value" }}, valid_session
        assigns(:customer).should eq(customer)
      end

      it "re-renders the 'edit' template" do
        customer = Customer.create! valid_attributes
        Customer.any_instance.stub(:save).and_return(false)
        put :update, {:id => customer.to_param, :customer => { "username" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested customer" do
      customer = Customer.create! valid_attributes
      expect {
        delete :destroy, {:id => customer.to_param}, valid_session
      }.to change(Customer, :count).by(-1)
    end

    it "redirects to the customers list" do
      delete :destroy, {:id => customer.to_param}, valid_session
      response.should redirect_to(customers_path)
    end
  end
end