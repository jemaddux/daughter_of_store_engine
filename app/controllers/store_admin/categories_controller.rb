class StoreAdmin::CategoriesController < ApplicationController
  layout 'admin/application'
  before_filter :require_store_admin

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @store = Store.find(current_store.id)
    @category = Category.new
  end

  def edit
    @store = Store.find(current_store.id)
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    
    if @category.save
      redirect_to @category, notice: 'Category was successfully created.' 
    else
      render action: "new" 
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to @category, notice: 'Category was successfully updated.' 
    else
      render action: "edit" 
    end

  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
  end
end
