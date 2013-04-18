class StoreStocker::ProductsController < ApplicationController
  layout 'admin/application'
  before_filter :require_store_admin_or_stocker

  def index
    @store = Store.find(current_store.id)
    @products = Product.all
  end

  def show
    @store = Store.find(current_store.id)
    @product = Product.find(params[:id])
  end

  def new
    @store = Store.find(current_store.id)
    @product = Product.new
  end

  def create
    @store = Store.find(current_store.id)
    @product = Product.new(params[:product])
    if @product.save
      @store.touch
      redirect_to store_admin_products_path(@store), notice: "Product was successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @store = Store.find(current_store.id)
    @product = Product.find(params[:id])
  end

  def update
    @store = Store.find(current_store.id)
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      @store.touch
      redirect_to store_admin_products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @store = Store.find(current_store.id)
    @product = Product.find(params[:id])
    if @product.destroy
      @store.touch
    end

    redirect_to store_admin_products_path, notice: 'Product was successfully removed.'
  end
end
