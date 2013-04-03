class Admin::ProductsController < ApplicationController
  layout 'admin/application.html.haml'

  before_filter :require_admin

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  def create
    category_ids = params[:product].delete(:categories)

    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save

        unless category_ids.nil?
          categories = category_ids.collect{ |category_id| Category.find_by_id(category_id) }.compact
          @product.categories = categories
        end
        
        format.html { redirect_to admin_products_path, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    category_ids = params[:product].delete(:categories)

    respond_to do |format|
      if @product.update_attributes(params[:product])

        unless category_ids.nil?
          categories = category_ids.collect{ |category_id| Category.find_by_id(category_id) }.compact
          @product.categories = categories
        end
    
        format.html { redirect_to admin_products_path, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @product = Product.find(params[:id])
  #   @product.destroy

  #   respond_to do |format|
  #     format.html { redirect_to products_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
 
  def require_admin
    if logged_in?
      redirect_to login_url unless current_user.admin
    else 
      redirect_to login_url
    end
  end
end