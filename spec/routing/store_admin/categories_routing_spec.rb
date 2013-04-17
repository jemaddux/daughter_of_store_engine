require "spec_helper"

describe StoreAdmin::CategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/store_admin/categories").should route_to("store_admin/categories#index")
    end

    it "routes to #new" do
      get("/store_admin/categories/new").should route_to("store_admin/categories#new")
    end

    it "routes to #show" do
      get("/store_admin/categories/1").should route_to("store_admin/categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/store_admin/categories/1/edit").should route_to("store_admin/categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/store_admin/categories").should route_to("store_admin/categories#create")
    end

    it "routes to #update" do
      put("/store_admin/categories/1").should route_to("store_admin/categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/store_admin/categories/1").should route_to("store_admin/categories#destroy", :id => "1")
    end

  end
end
