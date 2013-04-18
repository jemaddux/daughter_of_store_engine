class OrdersController < ApplicationController
  before_filter :require_login, except: [:show]
  skip_filter :scope_current_store

  def index
    if params[:status]
      @orders = Order.unscoped.where(status: params[:status]).find_all_by_customer_id(current_user.id)
    else
      @orders = Order.unscoped.find_all_by_customer_id(current_user.id)
    end
  end

  def show
    @order = Order.unscoped.find_by_customer_id(current_user.id)
    @products = @order.products.collect { |p| p.last.name }
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
