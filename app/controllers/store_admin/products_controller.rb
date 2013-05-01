class StoreAdmin::ProductsController < ApplicationController
  layout 'admin/application'
  before_filter :require_store_admin_or_admin

  def index
    @products = current_store.products.page(params[:page])
  end

  def show
    @product = current_store.products.find(params[:id])
  end

  def new
    @product = current_store.products.build
  end

  def create
    categories = params[:product].delete(:categories_list)
    product = current_store.products.create(params[:product])

    product.categories_list = categories

    if product.save
      store.touch
      redirect_to admin_products_path(store),
                notice: "Product was successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @product = current_store.products.find(params[:id])
  end

  def update
    categories = params[:product].delete(:categories_list)
    product = current_store.products.find(params[:id])

    if product.update_attributes(params[:product])
      product.categories_list = categories
      current_store.touch
      redirect_to admin_products_path, notice: 'Product Updated.'
    else
      render :edit
    end
  end

  def destroy
    product = current_store.products.find(params[:id])
    product.destroy
    current_store.touch
    redirect_to admin_products_path, notice: 'Product Removed.'
  end
end
