require 'spec_helper'

describe "customers/new" do
  before(:each) do
    assign(:customer, stub_model(Customer,
      :username => "MyString",
      :email => "MyString",
      :password => "",
      :password_confirmation => ""
    ).as_new_record)
  end

  it "renders new customer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", customers_path, "post" do
      assert_select "input#customer_username[name=?]", "customer[username]"
      assert_select "input#customer_email[name=?]", "customer[email]"
      assert_select "input#customer_password[name=?]", "customer[password]"
      assert_select "input#customer_password_confirmation[name=?]", "customer[password_confirmation]"
    end
  end
end
