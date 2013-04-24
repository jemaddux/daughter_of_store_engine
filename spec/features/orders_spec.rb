require 'spec_helper'

describe Order do 
  let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')}
  let!(:product) {Product.create!(name: 'Sunglasses', description: 'No more squinting!', price: 9.99, quantity: 10, featured: false, active: true, photo_url: 'http://placekitten.com/500/500', store_id: 1)}
  let!(:user) {Customer.create!(email: 'test@test.com', password: 'password', first_name: 'test', last_name: 'user', admin: false)}
  let!(:not_user) {Customer.create!(email: 'notuser@not_user.com', password: 'password', first_name: 'nottest', last_name: 'notuser', admin: false)}
  let!(:order1) {Order.for_customer(user,{1=>1},store.id)}
  let(:order2) {Order.for_customer(not_user,{1=>1},store.id)}

  context "given an order has been created" do 

    it "should be visible to anyone through the unique URL token path" do 
      visit url_token_path(order1.url_token)
      expect( current_path ).to eq url_token_path(order1.url_token)
    end

    def login_the_1st_user
      visit login_path
      fill_in 'email', with: 'test@test.com'
      fill_in 'password', with: 'password'
      click_button 'Login'
    end

    it "should be visible through the show when authenticated" do
      login_the_1st_user
      visit order_path(order1)
      expect(page).to have_content "Order Number:#"

      visit order_path(order2)
      expect(page).to have_content "Thats not your order"
    end
  end

end
