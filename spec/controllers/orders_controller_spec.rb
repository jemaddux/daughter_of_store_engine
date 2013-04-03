require 'spec_helper'

describe OrdersController do  

  let!(:customer) { Fabricate(:customer) }

  before(:each) do
    login_customer_post("admin", "admin")
  end

  def valid_attributes
    { customer_id:  1,
      status:       "pending", 
      total:        123 }
  end

  def valid_session
    {user_id: 1}
  end

  describe "GET index" do
    it "assigns all orders as @orders" do
      order = Order.create! valid_attributes
      get :index, {}, valid_session
      assigns(:orders).should eq([order])
    end
  end

  describe "GET show" do
    it "assigns the requested order as @order" do
      order = Order.create! valid_attributes
      get :show, {:id => order.to_param}, valid_session
      assigns(:order).should eq(order)
    end
  end


end
