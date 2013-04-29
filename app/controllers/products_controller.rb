class ProductsController < ApplicationController
  def index
    @products = current_store.products.where(:active => true).includes(
                                      :categories).page params[:page]
    render current_store.layout.to_sym
  end

  def show
    @product = current_store.products.find(params[:id])
  end
end
