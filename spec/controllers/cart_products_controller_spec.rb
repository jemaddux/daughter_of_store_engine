require 'spec_helper'

describe CartProductsController do
  before(:each) do
    @product = Product.create(  name: "something", 
                                description: "something else", 
                                price: 123,
                                quantity: 1,
                                active: true,
                                featured: true )
  end

  describe "destroy" do
    it "destroys a cart product" do
      cart = Cart.create!
      cart.add(@product, 1)
      cart_product = cart.cart_products.first
      expect {
        delete :destroy, {:id => cart_product.id}
      }.to change(CartProduct, :count).by(-1)
    end
  end
end
