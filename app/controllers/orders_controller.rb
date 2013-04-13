class OrdersController < ApplicationController
  before_filter :require_login
  skip_filter :scope_current_store

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
    @products = @order.order_products.map do |o|
      Product.unscoped.find_by_id(o.product_id)
    end
  end

end
