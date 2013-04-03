require 'spec_helper'

describe "shipping_addresses/show" do
  before(:each) do
    @shipping_address = assign(:shipping_address, stub_model(ShippingAddress,
      :customer => nil,
      :street => "Street",
      :city => "City",
      :state => "State",
      :zipcode => "Zipcode",
      :phone => "Phone"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Street/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zipcode/)
    rendered.should match(/Phone/)
  end
end
