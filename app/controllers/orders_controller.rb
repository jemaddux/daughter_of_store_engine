class OrdersController < ApplicationController
  def index
    @orders = Order.find_all_by_customer_id(current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end
end