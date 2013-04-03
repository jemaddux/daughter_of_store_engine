class Admin::ProductsController < ApplicationController
  layout 'admin/application.html.haml'

  before_filter :require_admin

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    category_ids = params[:product].delete(:categories)

    @product = Product.new(params[:product])

    if @product.save

      unless category_ids.nil?
        categories = category_ids.collect{ |category_id| Category.find_by_id(category_id) }.compact
        @product.categories = categories
      end
      
      redirect_to admin_products_path, notice: 'Product was successfully created.'
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
        categories = category_ids.collect{ |category_id| Category.find_by_id(category_id) }.compact
        @product.categories = categories
      end
  
      redirect_to admin_products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # def destroy
  #   @product = Product.find(params[:id])
  #   @product.destroy
  # 
  #   redirect_to products_url
  # end
end