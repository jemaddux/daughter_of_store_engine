class Admin::ProductsController < ApplicationController
  layout 'admin/application'
  before_filter :require_admin

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to admin_products_path,
      notice: 'Product was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
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
