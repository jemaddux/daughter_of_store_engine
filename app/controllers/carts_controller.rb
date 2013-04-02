class CartsController < ApplicationController
  def show
    @cart     = Cart.find_or_create_by_id(session[:cart_id])
    @products = @cart.products
  end

  def update
    @cart = Cart.find_or_create_by_id(session[:cart_id])
    
    session[:cart_id] = @cart.id

    product = Product.find(params[:product])
    @cart.add(product, params[:quantity].to_i)

    if @cart.update_attributes(params[:cart])
      redirect_to @cart, notice: "Your cart was successfully updated."
    else
      redirect_to @cart, notice: "Your cart could not be updated."
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    redirect_to products_path, notice: "Your cart was successfully cleared."
  end
end