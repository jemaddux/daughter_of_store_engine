require "spec_helper"

describe Admin::StoresController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/stores").should route_to("admin/stores#index")
    end

    it "routes to #new" do
      get("/admin/stores/new").should route_to("admin/stores#new")
    end

    it "routes to #show" do
      get("/admin/stores/1").should route_to("admin/stores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/stores/1/edit").should route_to("admin/stores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/stores").should route_to("admin/stores#create")
    end

    it "routes to #update" do
      put("/admin/stores/1").should route_to("admin/stores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/stores/1").should route_to("admin/stores#destroy", :id => "1")
    end

  end
end
