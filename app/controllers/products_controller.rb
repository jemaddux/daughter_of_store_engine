class ProductsController < ApplicationController
  def index
    @products = current_store.products.where(active: true).page params[:page]
    @cart = current_user.cart if logged_in?
  end

  def show
    @product = current_store.products.find(params[:id])
    @cart = current_user.cart if logged_in?
  end
end
