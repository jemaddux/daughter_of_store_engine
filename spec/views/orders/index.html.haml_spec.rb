require 'spec_helper'

describe "orders/index" do
  before(:each) do
    order = Order.create.save
    customer = Customer.new(username: "Mike").save
  end

  # it "renders a list of orders" do
  #   render
  #   # Run the generator again with the --webrat flag if you want to use webrat matchers
  #   assert_select "tr>td", :text => nil.to_s, :count => 2
  #   assert_select "tr>td", :text => "Status".to_s, :count => 2
  #   assert_select "tr>td", :text => "9.99".to_s, :count => 2
  # end
end
