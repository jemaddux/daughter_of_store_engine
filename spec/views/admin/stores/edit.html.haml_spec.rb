require 'spec_helper'

describe "admin/stores/edit" do
  before(:each) do
    @admin_store = assign(:admin_store, stub_model(Admin::Store))
  end

  it "renders the edit admin_store form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_store_path(@admin_store), "post" do
    end
  end
end
