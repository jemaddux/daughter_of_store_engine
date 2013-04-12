require 'spec_helper'

describe "admin/stores/new" do
  before(:each) do
    assign(:admin_store, stub_model(Admin::Store).as_new_record)
  end

  it "renders new admin_store form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_stores_path, "post" do
    end
  end
end
