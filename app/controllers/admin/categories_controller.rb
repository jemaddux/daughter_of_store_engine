class Admin::CategoriesController < ApplicationController


layout 'admin/application.html.haml'

  before_filter :require_admin

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_path, notice: 'Category was successfully created.' }
        format.json { render json: admin_categories_path, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: admin_categories_path.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to admin_categories_path, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: admin_categories_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @category = Category.find(params[:id])
  #   @category.destroy

  #   respond_to do |format|
  #     format.html { redirect_to categories_url }
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