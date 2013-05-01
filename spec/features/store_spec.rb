require 'spec_helper'

describe Store do
  let!(:user) {Customer.create!(email: 'test@test.com', password: 'password', first_name: 'test', last_name: 'user', admin: false)}
  name = "Carrot Sticks"
  path = "carrot-sticks"
  description = "We sell carrots and sticks"
  context 'when valid inputs are given' do
    it 'should be successfully created' do
      visit account_path
      fill_in 'email', with: 'test@test.com'
      fill_in 'password', with: 'password'
      click_button 'Login'
      expect(current_path).to eq account_path
      click_on 'Create a Store'
      fill_in 'store_name', with: name
      fill_in 'store_path', with: path
      fill_in 'store_description', with: description
      click_on 'Save'
      page.should have_content name
      page.should have_content description
    end

    it 'has the status: pending' do
      visit account_path
      fill_in 'email', with: 'test@test.com'
      fill_in 'password', with: 'password'
      click_button 'Login'
      click_on 'Create a Store'
      fill_in 'store_name', with: name
      fill_in 'store_path', with: path
      fill_in 'store_description', with: description
      click_on 'Save'
      expect(current_path).to have_content path
      visit home_path(path)
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


