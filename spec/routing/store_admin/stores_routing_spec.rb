require "spec_helper"

describe StoreAdmin::StoresController do
  describe "routing" do

    it "routes to #index" do
      get("/store_admin/stores").should route_to("store_admin/stores#index")
    end

    it "routes to #new" do
      get("/store_admin/stores/new").should route_to("store_admin/stores#new")
    end

    it "routes to #show" do
      get("/store_admin/stores/1").should route_to("store_admin/stores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/store_admin/stores/1/edit").should route_to("store_admin/stores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/store_admin/stores").should route_to("store_admin/stores#create")
    end

    it "routes to #update" do
      put("/store_admin/stores/1").should route_to("store_admin/stores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/store_admin/stores/1").should route_to("store_admin/stores#destroy", :id => "1")
    end

  end
end
