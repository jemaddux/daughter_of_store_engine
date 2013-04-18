class CartsController < ApplicationController

  def show 
    cart_products = session[:shopping_cart][current_store.id]
    if cart_products.empty?
      @shopping_cart = []
    else
      @shopping_cart = cart_products.collect{|k,v| [Product.unscoped.find(k), v]}
    end
  end

  def update
    session[:order_id] = nil
    product = Product.find(params[:product])
    
    if params[:quantity] == "1"  
      session[:shopping_cart][current_store.id][product.id] += 1 
    end
    if params[:subtract] == "1"
      session[:shopping_cart][current_store.id][product.id] -= 1
      if session[:shopping_cart][current_store.id][product.id] < 1
        session[:shopping_cart][current_store.id].delete(product.id)
      end
    end
    if params[:add] == "1"
      session[:shopping_cart][current_store.id][product.id] += 1 
    end

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
end
