require 'spec_helper'

describe CategoriesController do

  def valid_attributes
    { name: "some name",
      description: "some description" }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      category = Category.create! valid_attributes
      get :index, {}, valid_session
      assigns(:categories).should eq([category])
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      category = Category.create! valid_attributes
      get :show, {:id => category.to_param}, valid_session
      assigns(:category).should eq(category)
    end
  end
end