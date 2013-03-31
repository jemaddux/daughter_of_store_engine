class CartProductsController < ApplicationController

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy

    respond_to do |format|
      format.html { redirect_to cart_path, method: :put }
      format.json { head :no_content }
    end
  end
end