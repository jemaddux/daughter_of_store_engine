class Admin::OrdersController < ApplicationController  # GET /orders
  layout 'admin/application.html.haml'

  # before_filter :require_admin

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

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      redirect_to admin_orders_path, notice: 'Order was successfully updated.'
    else
      render action: "edit"
    end
  end
end