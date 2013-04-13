require 'spec_helper'

describe "StoreAdmin::Stores" do
  describe "GET /store_admin_stores" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get store_admin_stores_path
      response.status.should be(200)
    end
  end
end
