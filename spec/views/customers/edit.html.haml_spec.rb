require 'spec_helper'

describe "customers/edit" do
  before(:each) do
    @customer = assign(:customer, stub_model(Customer,
      :username => "MyString",
      :email => "MyString",
      :password => "",
      :password_confirmation => ""
    ))
  end

  it "renders the edit customer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", customer_path(@customer), "post" do
      assert_select "input#customer_username[name=?]", "customer[username]"
      assert_select "input#customer_email[name=?]", "customer[email]"
      assert_select "input#customer_password[name=?]", "customer[password]"
      assert_select "input#customer_password_confirmation[name=?]", "customer[password_confirmation]"
    end
  end
end
