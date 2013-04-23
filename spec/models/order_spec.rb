require 'spec_helper'

describe Order do
  
  let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')}

  let!(:product) {Product.create!(name: 'Sunglasses', description: 'No more squinting!', price: 9.99, quantity: 100, featured: false, active: true, photo_url: 'http://placekitten.com/500/500', store_id: 1)}

  let!(:user) {Customer.create!(email: 'test@test.com', password: 'password', first_name: 'test', last_name: 'user', admin: false)}
    
  context "valid orders" do
    
    it "should should increase order quantity" do 
      cart_products = {1=>1}
      beginning_order_count = Order.unscoped.count
      Order.for_customer(user,cart_products,store.id)
      expect(Order.unscoped.count).to eq beginning_order_count+1
    end

    it "should decrease product inventory by amount ordered" do
      units = 30
      cart_products = {product.id => units}
      beginning_product_quantity = product.quantity
      Order.for_customer(user,cart_products,store.id)
      product_after_order = Product.unscoped.find(product.id)

      expect(product_after_order.quantity).to eq beginning_product_quantity - units
      
    end

  end
end
