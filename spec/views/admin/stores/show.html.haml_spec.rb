require 'spec_helper'

describe "admin/stores/show" do
  before(:each) do
    @admin_store = assign(:admin_store, stub_model(Admin::Store))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
