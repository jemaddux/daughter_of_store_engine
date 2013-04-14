require 'spec_helper'

describe 'Checkout Flow:' do

  let!(:store) {Store.create(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')}
  let!(:product) {Product.create(name: 'Sunglasses', description: 'No more squinting!', price: 9.99, quantity: 10, featured: false, active: true, photo_url: 'http://placekitten.com/500/500', store_id: 1)}
  let!(:user) {Customer.create(username: 'test', email: 'test@test.com', password: 'password', first_name: 'test', last_name: 'user', admin: false)}
  let(:shipping_address) {ShippingAddress.create(customer_id: 1, street: '3181 W Avondale Dr.', city: 'Denver', state: 'CO', zipcode: '80204', phone: '8155207020')}

  context 'when the customer is anonymous' do
    it 'it prompts the customer to login, signup, or checkout as guest' do
      visit '/cool-sunglasses'
      click_link 'Products'
      click_link 'product-0'
      click_button 'Add to Cart'
      click_link 'Cart'
      click_link 'Checkout'
      page.should have_content('Sign in')
      page.should have_content('Check Out as a Guest')
      page.should have_content('Create Account')
    end

    context 'and the customer chooses to login' do
      it 'it logs the customer in and redirects back to the order confirmation page' do
        visit '/cool-sunglasses'
        click_link 'Products'
        click_link 'product-0'
        click_button 'Add to Cart'
        click_link 'Cart'
        click_link 'Checkout'
        fill_in 'username', with: 'test'
        fill_in 'password', with: 'password'
        click_button 'Login'
        page.should have_content 'Review Order Details'
      end
    end

    context 'and the customer chooses to signup' do
      it 'it takes the customer to the signup page and then redirects back to the order confirmation page' do
        visit '/cool-sunglasses'
        click_link 'Products'
        click_link 'product-0'
        click_button 'Add to Cart'
        click_link 'Cart'
        click_link 'Checkout'
        fill_in 'customer_first_name', with: 'test2'
        fill_in 'customer_last_name', with: 'user2'
        fill_in 'customer_username', with: 'test2'
        fill_in 'customer_email', with: 'test2@test2.com'
        fill_in 'customer_password', with: 'password'
        fill_in 'customer_password_confirmation', with: 'password'
        fill_in 'password', with: 'password'
        click_button 'Save'
        page.should have_content 'Review Order Details'
        page.should have_content 'Shipping Information is Required'
      end
    end

    context 'and the customer chooses to checkout as a guest' do
      it 'it takes the customer to the order confirmation page upon filling out the guest form' do
        visit '/cool-sunglasses'
        click_link 'Products'
        click_link 'product-0'
        click_button 'Add to Cart'
        click_link 'Cart'
        click_link 'Checkout'
        fill_in 'first_name', with: 'Logan'
        fill_in 'last_name', with: 'Sears'
        fill_in 'email', with: 'lsears@test.com'
        click_button 'Checkout as Guest'
        page.should have_content 'Review Order Details'
      end
    end
  end

  context 'when the customer is logged in' do
    context 'when the customer does not have a saved shipping address' do
      it 'it takes the user to his/her order confirmation page and requires them to enter shipping details' do
        visit '/cool-sunglasses'
        click_link 'Login / Signup'
        fill_in 'username', with: 'test'
        fill_in 'password', with: 'password'
        click_button 'Login'
        click_link 'Products'
        click_link 'product-0'
        click_button 'Add to Cart'
        click_link 'Cart'
        click_link 'Checkout'
        page.should have_field 'shipping_address_street'
      end
    end

    context 'when the customer has a saved shipping address' do
      it 'it takes the user to his/her order confirmation page and does not require any further information' do
        shipping_address
        visit '/cool-sunglasses'
        click_link 'Login / Signup'
        fill_in 'username', with: 'test'
        fill_in 'password', with: 'password'
        click_button 'Login'
        click_link 'Products'
        click_link 'product-0'
        click_button 'Add to Cart'
        click_link 'Cart'
        click_link 'Checkout'
        page.should have_content 'Review Order Details'
        page.should_not have_content 'Shipping Information is Required'
      end
    end
  end

end
