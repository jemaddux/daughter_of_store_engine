class StoreAdmin::CategoriesController < ApplicationController
  layout 'admin/application'
  before_filter :require_store_admin_or_admin

  def index
    @categories = current_store.categories.all
  end

  def show
    @category = current_store.categories.find(params[:id])
  end

  def new
    @store = current_store
    @category = Category.new
  end

  def edit
    @store = current_store
    @category = current_store.categories.find(params[:id])
  end

  def create
    @category = current_store.categories.new(params[:category])

    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @category = current_store.categories.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render action: "edit"
    end

  end

  def destroy
    @category = current_store.categories.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path, notice: 'Category was successfully deleted.'
  end
end
