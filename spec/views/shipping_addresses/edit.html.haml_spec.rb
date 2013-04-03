require 'spec_helper'

describe "shipping_addresses/edit" do
  before(:each) do
    @shipping_address = assign(:shipping_address, stub_model(ShippingAddress,
      :customer => nil,
      :street => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zipcode => "MyString",
      :phone => "MyString"
    ))
  end

  it "renders the edit shipping_address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", shipping_address_path(@shipping_address), "post" do
      assert_select "input#shipping_address_customer[name=?]", "shipping_address[customer]"
      assert_select "input#shipping_address_street[name=?]", "shipping_address[street]"
      assert_select "input#shipping_address_city[name=?]", "shipping_address[city]"
      assert_select "input#shipping_address_state[name=?]", "shipping_address[state]"
      assert_select "input#shipping_address_zipcode[name=?]", "shipping_address[zipcode]"
      assert_select "input#shipping_address_phone[name=?]", "shipping_address[phone]"
    end
  end
end
