require 'spec_helper'

describe "store_admin/stores/show" do
  before(:each) do
    @store_admin_store = assign(:store_admin_store, stub_model(StoreAdmin::Store))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
