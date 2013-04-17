require 'spec_helper'

describe "store_admin/categories/show" do
  before(:each) do
    @store_admin_category = assign(:store_admin_category, stub_model(StoreAdmin::Category))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
