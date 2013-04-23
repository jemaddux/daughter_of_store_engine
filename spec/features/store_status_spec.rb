require 'spec_helper'

# test that stores' homepage shows appropriate status of stores
# Given that a store has been created but not yet approved by site admin
# When a user types in the url of that store
# Then the store's page shows a message saying that the store is pending

describe Store do
  let!(:user) {Customer.create!(email: 'test@test.com', password: 'password', first_name: 'test', last_name: 'user', admin: false)}

  context 'when a store is created' do
    it 'is successfully created' do

      visit stores_path
      click_link 'New Store'
      fill_in 'email', with: 'test@test.com'
      fill_in 'password', with: 'password'
      click_button 'Login'
      fill_in 'store_name', with: 'carrot sticks'
      fill_in 'store_path', with: 'carrot-sticks'
      fill_in 'store_description', with: 'we sell carrots and sticks'
      click_button 'Save'
      page.should have_content('Store Name: carrot sticks')
    end
  end
end