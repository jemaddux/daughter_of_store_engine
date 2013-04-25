class CategoriesController < ApplicationController
  def index
    redirect_to home_path(current_store)
  end

  def show
    @category = current_store.categories.find(params[:id])
    @products = @category.products.where(active: true).page params[:page]
  end
end
