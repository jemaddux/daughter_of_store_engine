class Admin::CustomersController < ApplicationController 
  layout 'admin/application.html.haml'

  # before_filter :require_admin

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to admin_orders_path
  end
end