require 'spec_helper'

describe Admin::CategoriesController do
  let!(:product)  {Product.create!(
      name:        "Some Product", 
      description: "This is my product description.",
      price:       123.99,
      quantity:    3,
      featured:    true,
      active:      true )
}
  let!(:category) { product.categories.create(
      name: "some name",
      description: "some description") }

  def valid_session
    { user_id: 1 }
  end

  def valid_attributes
    { name: "another name",
      description: "some description" }
  end

  let!(:customer) { Fabricate(:customer) }

  before(:each) do
    login_customer_post("admin", "admin")
  end

  describe "#index" do
    it "assigns all categories as @categories" do
      get :index, {}, valid_session
      expect( assigns(:categories)).to eq([category])
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      get :new, {}, valid_session
      assigns(:category).should be_a_new(Category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      get :edit, {:id => category.to_param}, valid_session
      assigns(:category).should eq(category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, {:category => valid_attributes}, valid_session
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, {:category => valid_attributes}, valid_session
        assigns(:category).should be_a(Category)
        assigns(:category).should be_persisted
      end

      it "redirects to the created category" do
        post :create, {:category => valid_attributes}, valid_session
        response.should redirect_to( admin_categories_path )
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        Category.any_instance.stub(:save).and_return(false)
        post :create, {:category => {  }}, valid_session
        assigns(:category).should be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        Category.any_instance.stub(:save).and_return(false)
        post :create, {:category => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested category" do
        category = Category.create! valid_attributes
        Category.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => category.to_param, :category => { "these" => "params" }}, valid_session
      end

      it "assigns the requested category as @category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        assigns(:category).should eq(category)
      end

      it "redirects to the category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}, valid_session
        response.should redirect_to( admin_categories_path )
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        category = Category.create! valid_attributes
        Category.any_instance.stub(:save).and_return(false)
        put :update, {:id => category.to_param, :category => {  }}, valid_session
        assigns(:category).should eq(category)
      end

      it "re-renders the 'edit' template" do
        category = Category.create! valid_attributes
        Category.any_instance.stub(:save).and_return(false)
        put :update, {:id => category.to_param, :category => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, {:id => category.to_param}, valid_session
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = Category.create! valid_attributes
      delete :destroy, {:id => category.to_param}, valid_session
      expect(response).to redirect_to(categories_path)
    end
  end
end
