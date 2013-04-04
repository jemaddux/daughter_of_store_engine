require 'spec_helper'

describe Admin::OrdersController do
  def valid_attributes
    {}
  end

  let!(:customer) { Fabricate(:customer) }

  before(:each) do
   login_customer_post("admin", "admin")
  end
  
  def valid_session
    { user_id: 1 }
  end

  describe "GET index" do
    it "assigns all orders as @orders" do
      order = Order.create! valid_attributes
      get :index, {}, valid_session
      expect(Order.all.include?(order)).to be_true
    end
  end

  describe "GET edit" do
    it "assigns the requested order as @order" do
      order = Order.create! valid_attributes
      get :edit, {:id => order.to_param}, valid_session
      assigns(:order).should eq(order)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested order" do
        order = Order.create! valid_attributes
        Order.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => order.to_param, :order => { "these" => "params" }}, valid_session
      end

      it "assigns the requested order as @order" do
        order = Order.create! valid_attributes
        put :update, {:id => order.to_param, :order => valid_attributes}, valid_session
        assigns(:order).should eq(order)
      end

      it "redirects to the order" do
        order = Order.create! valid_attributes
        put :update, {:id => order.to_param, :order => valid_attributes}, valid_session
        response.should redirect_to(admin_orders_path)
      end
    end

    describe "with invalid params" do
      it "assigns the Order as @order" do
        order = Order.create! valid_attributes
        Order.any_instance.stub(:save).and_return(false)
        put :update, {:id => order.to_param, :order => {  }}, valid_session
        assigns(:order).should eq(order)
      end

      it "re-renders the 'edit' template" do
        order = Order.create! valid_attributes
        Order.any_instance.stub(:save).and_return(false)
        put :update, {:id => order.to_param, :order => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end
end