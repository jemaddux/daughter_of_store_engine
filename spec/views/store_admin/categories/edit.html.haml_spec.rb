require 'spec_helper'

describe "store_admin/categories/edit" do
  before(:each) do
    @store_admin_category = assign(:store_admin_category, stub_model(StoreAdmin::Category))
  end

  it "renders the edit store_admin_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", store_admin_category_path(@store_admin_category), "post" do
    end
  end
end
