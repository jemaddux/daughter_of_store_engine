require 'spec_helper'

describe Order do
  
  let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')}

  let!(:product) {Product.create!(name: 'Sunglasses', description: 'No more squinting!', price: 9.99, quantity: 100, featured: false, active: true, photo_url: 'http://placekitten.com/500/500', store_id: 1)}

  let!(:user) {Customer.create!(email: 'test@test.com', password: 'password', first_name: 'test', last_name: 'user', admin: false)}
    
  context "valid orders" do

    it "should be valid" do 
      cart_products = {1=>1}
      order = Order.for_customer(user,cart_products,store.id)
      expect(order).to be_kind_of Order
    end

    it "#products should be an array" do 
      cart_products = {1=>1}
      order = Order.for_customer(user,cart_products,store.id)
      expect(order.products).to be_kind_of Array
    end

    it '#products should be an array of Products and OrderProducts' do 
      cart_products = {1=>1}
      order = Order.for_customer(user,cart_products,store.id)
      line_item, product = order.products.first

      expect(line_item).to be_kind_of OrderProduct
      expect(product).to be_kind_of Product
    end

    it 'should find its own subtotal' do 
      cart_products = {1=>1}
      order = Order.for_customer(user,cart_products,store.id)
    end

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

    context "#generate_token" do
      it "should happen before save" do 
        cart_products = {1=>1}
        order = Order.for_customer(user,cart_products,store.id)
        expect(order.url_token).to be
      end
    end

    context "#calculate_total" do 
      it "should calculate the total" do
        units = 1
        cart_products = {product.id=>units}
        order = Order.for_customer(user,cart_products,store.id)
        expect(order.total).to eq product.price*units
      end
    end
  end
end
