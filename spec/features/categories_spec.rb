require 'spec_helper'

describe CategoriesController do
  let :store do
    Store.create(name: "Sample Store", path: "store_path", status: "live")
  end

  describe "/products" do
    it "returns lots of stuff" do
      visit "/#{store.path}/products"
      expect(current_path).to eq "/store_path/products"
    end
  end
end
