require 'spec_helper'

describe Order do 
  let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')}
  let!(:product) {Product.create!(name: 'Sunglasses', description: 'No more squinting!', price: 9.99, quantity: 10, featured: false, active: true, photo_url: 'http://placekitten.com/500/500', store_id: 1)}
  let!(:user) {Customer.create!(email: 'test@test.com', password: 'password', first_name: 'test', last_name: 'user', admin: false)}
  let!(:order) {Order.for_customer(user,{1=>1},store.id)}

  context "given an order has been created" do 
    it "should be valid" do 
      expect(order).to be_kind_of Order
      expect(Order.unscoped.count).to eq 1
    end

    it "should be visible to anyone through the unique URL token path" do 
      visit url_token_path(store,order.url_token)
      expect( current_path ).to eq url_token_path(store,order.url_token)
    end

    it "should be visible through the show when authenticated"



  end

end
