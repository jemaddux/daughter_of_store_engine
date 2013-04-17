require 'spec_helper'

describe "store_admin/categories/index" do
  before(:each) do
    assign(:store_admin_categories, [
      stub_model(StoreAdmin::Category),
      stub_model(StoreAdmin::Category)
    ])
  end

  it "renders a list of store_admin/categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
