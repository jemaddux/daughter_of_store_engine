require 'spec_helper'

describe "admin/stores/index" do
  before(:each) do
    assign(:admin_stores, [
      stub_model(Admin::Store),
      stub_model(Admin::Store)
    ])
  end

  it "renders a list of admin/stores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
