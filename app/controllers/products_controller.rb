class ProductsController < ApplicationController
  def index
    @products = Product.active
    @cart = current_user.cart if logged_in?

    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
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