require 'spec_helper'

describe "customers/show" do
  before(:each) do
    @customer = assign(:customer, stub_model(Customer,
      :username => "Username",
      :email => "Email",
      :password => "",
      :password_confirmation => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Username/)
    rendered.should match(/Email/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
