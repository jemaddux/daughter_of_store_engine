class ProductsController < ApplicationController
  def index
    @products = Product.active
    @cart = current_user.carts.last if logged_in?

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def show
    @product = Product.find(params[:id])
    @cart = current_user.carts.last

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end
end