require 'spec_helper'

describe "store_admin/stores/index" do
  before(:each) do
    assign(:store_admin_stores, [
      stub_model(StoreAdmin::Store),
      stub_model(StoreAdmin::Store)
    ])
  end

  it "renders a list of store_admin/stores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
