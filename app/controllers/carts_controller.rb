class CartsController < ApplicationController

  def show
    cart_products = session[:shopping_cart][current_store.id]
    if cart_products.empty?
      @shopping_cart = []
    else
      @shopping_cart = cart_products.collect{|k,v| [Product.unscoped.find(k), v]}
      @order_total = @shopping_cart.reduce(0){|memo,(p,q)|memo+=(p.price*q)}
    end
  end

  def update
    session[:order_id] = nil
    product = Product.find(params[:product])
    add_to_cart(product.id, params[:quantity]) if params[:quantity]
    subtract_from_cart(product.id) if params[:subtract] == "1"
    add_to_cart(product.id) if params[:add] == "1"

    redirect_to :back, notice: "Cart Updated"
  end

  def destroy
    if params[:remove]
      product = Product.find(params[:remove])
      session[:shopping_cart][current_store.id].delete(product.id)
      redirect_to carts_path, notice: "Product removed."
    elsif params[:clear_cart]
      session[:shopping_cart].delete(current_store.id)
      redirect_to carts_path, notice: "Cart has been cleared."
    end
  end


private

  def subtract_from_cart(id)
    session[:shopping_cart][current_store.id][id] -= 1
    if session[:shopping_cart][current_store.id][id] < 1
      session[:shopping_cart][current_store.id].delete(id)
    end
  end

  def add_to_cart(id, quantity="1")
    session[:shopping_cart][current_store.id][id] += quantity.to_i
  end


end
