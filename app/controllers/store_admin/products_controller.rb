class StoreAdmin::ProductsController < ApplicationController
  layout 'admin/application'
  before_filter :require_store_admin_or_admin

  def index
    @store = current_store
    @products = current_store.products.page params[:page]
  end

  def show
    @store = current_store
    @product = current_store.products.find(params[:id])
  end

  def new
    @store = current_store
    @product = Product.new
  end

  def create
    store = current_store
    product = current_store.products.create(params[:product])
    product.categories.each{|c|c.store_id = current_store.id; c.save}
    if product.save
      store.touch
      redirect_to admin_products_path(store),
                notice: "Product was successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @store = current_store
    @product = current_store.products.find(params[:id])
  end

  def update
    @store = current_store
    @product = current_store.products.find(params[:id])
    if @product.update_attributes(params[:product])
      @store.touch
      redirect_to admin_products_path,
                notice: 'Product was successfully updated.'
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
