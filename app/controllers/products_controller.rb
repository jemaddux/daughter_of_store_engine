class ProductsController < ApplicationController
  def index
    @products = Product.all
    @cart = current_user.cart if logged_in?
  end

  def show
    @product = Product.find(params[:id])
    @cart = current_user.cart if logged_in?

    respond_to do |format|
      format.html
      format.json { render json: @product }
    end
  end
end