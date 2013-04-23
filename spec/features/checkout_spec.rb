require 'spec_helper'

describe 'Checkout Flow:' do

  let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')}
  let!(:product) {Product.create!(name: 'Sunglasses', description: 'No more squinting!', price: 9.99, quantity: 10, featured: false, active: true, photo_url: 'http://placekitten.com/500/500', store_id: 1)}
  let!(:user) {Customer.create!(email: 'test@test.com', password: 'password', first_name: 'test', last_name: 'user', admin: false)}


  def add_product_to_cart_and_checkout
    click_link 'Products'
    click_link 'product-0'
    click_button 'Add to Cart'
    click_link 'Cart'
    click_link 'Checkout'
  end

  context 'when the customer is anonymous' do
    it 'it prompts the customer to login, signup, or checkout as guest' do
      visit '/cool-sunglasses'
      
      add_product_to_cart_and_checkout

      page.should have_content('Sign in')
      page.should have_content('Check Out as a Guest')
      page.should have_content('Create Account')
    end

    context 'and the customer chooses to login' do
      it 'login and redirect to the order confirmation page' do
        visit '/cool-sunglasses'
        
        add_product_to_cart_and_checkout

        within("#login-form") do 
          fill_in 'email', with: 'test@test.com'
          fill_in 'password', with: 'password'
          click_button 'Login'
        end
        page.should have_content 'Review Order Details'
      end
    end

    context 'and the customer chooses to signup' do
      it 'it takes the customer to the signup page and then redirects back to the order confirmation page' do
        visit '/cool-sunglasses'
        
        add_product_to_cart_and_checkout

        fill_in 'customer_first_name', with: 'test2'
        fill_in 'customer_last_name', with: 'user2'
        fill_in 'customer_email', with: 'test2@test2.com'
        fill_in 'customer_password', with: 'password'
        fill_in 'customer_password_confirmation', with: 'password'
        click_button 'Create Account'
        page.should have_content 'Review Order Details'
      end
    end

    context 'and the customer chooses to checkout as a guest' do
      it 'it takes the customer to the order confirmation page upon filling out the guest form' do
        visit '/cool-sunglasses'
        
        add_product_to_cart_and_checkout

        within("#guest-checkout-form") do 
          fill_in 'first_name', with: 'Logan'
          fill_in 'last_name', with: 'Sears'
          fill_in 'email', with: 'lsears@test.com'
        end
        click_button 'Checkout as Guest'
        page.should have_content 'Review Order Details'
      end
    end
  end

  context 'when the customer is logged in' do
    def visit_store_and_login
      visit '/cool-sunglasses'
      click_link 'Login / Signup'
      fill_in 'email', with: 'test@test.com'
      fill_in 'password', with: 'password'
      click_button 'Login'
    end

    context 'when the customer does not have a saved shipping address' do
      it 'it does not allow them to pay while address fields exist' do
        visit_store_and_login
        
        add_product_to_cart_and_checkout

        expect( page ).to_not have_content "Pay with Card"

        expect( page ).to have_field 'shipping_address_street'
        expect( page ).to have_field 'shipping_address_city'
        expect( page ).to have_field 'shipping_address_state'
        expect( page ).to have_field 'shipping_address_zipcode'
      end
    end

    context 'when the customer wants to save a shipping address' do
      it 'accepts shipping details and reloads the saved data into a table' do
        visit_store_and_login
        
        add_product_to_cart_and_checkout
        within("#shipping-form") do 
          fill_in 'shipping_address_street', with: "1062 delaware st"
          fill_in 'shipping_address_city', with: "Denver"
          select('Colorado', :from => 'shipping_address_state')
          fill_in 'shipping_address_zipcode', with: "80204"
          fill_in 'shipping_address_phone', with: "4255551212"
          click_button "Save"
        end
        expect(current_path).to eq new_charge_path(store)
        within("#shipping") do 
          expect(page).to have_content "1062 delaware st"
          expect(page).to have_content "Denver"
          expect(page).to have_content "CO"
        end
      end
    end

    context 'when the customer has a saved shipping address' do
      it 'it takes the user to his/her order confirmation page and does not require any further information' do
        shipping_address = ShippingAddress.create!(customer_id: 1, street: '1062 Delaware ST', city: 'Denver', state: 'CO', zipcode: '80204', phone: '4255551212')
        visit_store_and_login
        
        add_product_to_cart_and_checkout

        page.should have_content 'Review Order Details'
      end
    end
  end

end
