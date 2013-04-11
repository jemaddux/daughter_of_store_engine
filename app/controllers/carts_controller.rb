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
    product = Product.find(params[:product])
    
    if params[:quantity] == "1"  
      session[:shopping_cart][current_store.id][product.id] += 1 
    end
    if params[:subtract] == "1"
      session[:shopping_cart][current_store.id][product.id] -= 1 
    end
    if params[:add] == "1"
      session[:shopping_cart][current_store.id][product.id] += 1 
    end

    redirect_to :back, notice: "item added to cart"

    # @cart = Cart.find_or_create_by_id(session[:cart_id], total: 0)
    # session[:cart_id] = @cart.id
    # product = Product.find(params[:product])
    # @cart.add(product, params[:quantity].to_i)
    # if @cart.update_attributes(params[:cart])
    #   redirect_to @cart, notice: "Your cart was successfully updated."
    # else
    #   redirect_to @cart, notice: "Your cart could not be updated."
    # end
  end

  def destroy
    product = Product.find(params[:product])
    session[:shopping_cart][current_store.id].delete(product.id) 
    # @cart = Cart.find(params[:id])
    # @cart.destroy

    # session[:cart_id] = nil
    redirect_to carts_path, notice: "Your cart was successfully cleared."
  end
end
