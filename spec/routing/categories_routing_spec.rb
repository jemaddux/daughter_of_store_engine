require "spec_helper"

describe CategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/categories").should route_to("categories#index")
    end

    it "routes to #show" do
      get("/categories/1").should route_to("categories#show", :id => "1")
    end

  end
end
