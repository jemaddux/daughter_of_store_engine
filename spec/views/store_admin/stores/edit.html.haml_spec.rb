require 'spec_helper'

describe "store_admin/stores/edit" do
  before(:each) do
    @store_admin_store = assign(:store_admin_store, stub_model(StoreAdmin::Store))
  end

  it "renders the edit store_admin_store form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", store_admin_store_path(@store_admin_store), "post" do
    end
  end
end
