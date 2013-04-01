require 'spec_helper'

describe "orders/edit" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :customer => nil,
      :status => "MyString",
      :total => "9.99"
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", order_path(@order), "post" do
      assert_select "input#order_customer[name=?]", "order[customer]"
      assert_select "input#order_status[name=?]", "order[status]"
      assert_select "input#order_total[name=?]", "order[total]"
    end
  end
end
