class Admin::OrdersController < ApplicationController  # GET /orders
  layout 'admin/application.html.haml'

  before_filter :require_admin

  def index
    if params[:status]
      @orders = Order.find_all_by_status(params[:status])
    else
      @orders = Order.all
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(params[:order])

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      redirect_to admin_orders_path, notice: 'Order was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to admin_orders_path
  end


  private
 
  def require_admin
    if logged_in?
      redirect_to login_url unless current_user.admin
    else 
      redirect_to login_url
    end
  end
end