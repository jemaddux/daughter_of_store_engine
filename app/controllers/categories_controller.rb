class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @active_products = Product.find_all_by_active(true)
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end
end