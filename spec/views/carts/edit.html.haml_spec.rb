require 'spec_helper'

describe "carts/edit" do
  before(:each) do
    @cart = assign(:cart, stub_model(Cart,
      :customer => nil
    ))
  end

  it "renders the edit cart form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", cart_path(@cart), "post" do
      assert_select "input#cart_customer[name=?]", "cart[customer]"
    end
  end
end
