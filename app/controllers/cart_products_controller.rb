class CartProductsController < ApplicationController

  def destroy
    @cart = Cart.find(session[:cart_id])

    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy

    @cart.recalculate
    @cart.save

    respond_to do |format|
      format.html { redirect_to cart_path, method: :put }
      format.json { head :no_content }
    end
  end
end