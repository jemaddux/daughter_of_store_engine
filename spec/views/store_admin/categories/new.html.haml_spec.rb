require 'spec_helper'

describe "store_admin/categories/new" do
  before(:each) do
    assign(:store_admin_category, stub_model(StoreAdmin::Category).as_new_record)
  end

  it "renders new store_admin_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", store_admin_categories_path, "post" do
    end
  end
end
