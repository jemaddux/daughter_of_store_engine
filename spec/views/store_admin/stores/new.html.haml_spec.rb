require 'spec_helper'

describe "store_admin/stores/new" do
  before(:each) do
    assign(:store_admin_store, stub_model(StoreAdmin::Store).as_new_record)
  end

  it "renders new store_admin_store form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", store_admin_stores_path, "post" do
    end
  end
end
