require 'spec_helper'

describe "carts/index" do
  before(:each) do
    assign(:carts, [
      stub_model(Cart,
        :customer => nil
      ),
      stub_model(Cart,
        :customer => nil
      )
    ])
  end

  it "renders a list of carts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
