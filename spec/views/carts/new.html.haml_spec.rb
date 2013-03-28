require 'spec_helper'

describe "carts/new" do
  before(:each) do
    assign(:cart, stub_model(Cart,
      :customer => nil
    ).as_new_record)
  end

  it "renders new cart form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", carts_path, "post" do
      assert_select "input#cart_customer[name=?]", "cart[customer]"
    end
  end
end
