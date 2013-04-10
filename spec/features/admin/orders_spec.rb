require 'spec_helper'

describe "orders" do
  Order.create(customer_id: 1, id: 1, status: "processed", total: 1000)

  let!(:customer) { Fabricate(:customer) }

  before(:each) do
    login_customer_post("admin", "admin")
  end

  context "when the admin is logged in" do
    it "should display the categories" do
      visit admin_path
      click_on "Orders"
      expect( page ).to have_content "Orders"
    end

    it "should display a category" do
      visit admin_path
      click_on "Orders"
      click_on "processed"
      expect( page ).to have_content "Customer"
    end
  end
end
