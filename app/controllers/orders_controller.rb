class OrdersController < ApplicationController
  before_filter :require_login
  skip_filter :scope_current_store

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
    @products = @order.products
  end

  def unique_order_confirmation
    @order = Order.unscoped.find_by_url_token(params[:url_token])
    if @order
      @order
      @products = @order.products
    else
      redirect_to root_path, notice: "Sorry, that was an invalid page"
    end
  end
end
