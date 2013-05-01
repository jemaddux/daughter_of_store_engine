require 'spec_helper'

describe CategoriesController do
  let :store do
    Store.create(name: "Sample Store", path: "storepath", status: "live")
  end

  describe "/products" do
    it "returns lots of stuff" do
      visit "/#{store.path}/products"
      expect(current_path).to eq "/storepath/products"
    end
  end
end
