class CartProductsController < ApplicationController
  def destroy
    @cart = Cart.find(session[:cart_id])

    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy

    @cart.recalculate
    @cart.save

    redirect_to cart_path, method: :put
  end
end