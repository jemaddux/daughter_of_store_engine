require 'spec_helper'

describe "shipping_addresses/index" do
  before(:each) do
    assign(:shipping_addresses, [
      stub_model(ShippingAddress,
        :customer => nil,
        :street => "Street",
        :city => "City",
        :state => "State",
        :zipcode => "Zipcode",
        :phone => "Phone"
      ),
      stub_model(ShippingAddress,
        :customer => nil,
        :street => "Street",
        :city => "City",
        :state => "State",
        :zipcode => "Zipcode",
        :phone => "Phone"
      )
    ])
  end

  it "renders a list of shipping_addresses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zipcode".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
  end
end
