require 'spec_helper'

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

    it 'has the status: pending' do
      visit stores_path
      click_link 'New Store'
      fill_in 'email', with: 'test@test.com'
      fill_in 'password', with: 'password'
      click_button 'Login'
      fill_in 'store_name', with: 'carrot sticks'
      fill_in 'store_path', with: 'carrot-sticks'
      fill_in 'store_description', with: 'we sell carrots and sticks'
      click_button 'Save'
      visit '/carrot-sticks'
      page.should have_content('Store is Pending Approval by Site Admin')
    end
  end

  context 'when the site admin rejects a store' do
    let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'declined')}
    it 'displays a message that the store has been rejected' do
      visit '/cool-sunglasses'
      page.should have_content('Store has been rejected')
    end
  end

  context 'when a site admin disables a store' do
    let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'disabled')}
    it 'should display a message that the store is down for maintenance' do
      visit '/cool-sunglasses'
      page.should have_content('This store is down for maintenance')
    end
  end
end


