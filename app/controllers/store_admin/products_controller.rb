class StoreAdmin::ProductsController < ApplicationController
  layout 'admin/application'
  before_filter :require_store_admin
  #skip_filter :scope_current_store

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
      redirect_to store_admin_products_path(@store.path),
      notice: 'Product was successfully created.'
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

    category_ids = params[:product].delete(:categories)

    if @product.update_attributes(params[:product])

      unless category_ids.nil?
        categories = category_ids.collect do |category_id|
          Category.find_by_id(category_id)
        end.compact

        @product.categories = categories
      end

      redirect_to admin_products_path,
      notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to admin_products_path
  end
end
