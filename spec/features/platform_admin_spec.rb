require 'spec_helper'

describe 'Platform Admin:' do

  let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses')}
  let!(:admin) {Customer.create!(email: 'admin@admin.com', password: 'password', first_name: 'admin', last_name: 'admin', admin: true)}
  let!(:user) {Customer.create!(email: 'test@test.com', password: 'password', first_name: 'user', last_name: 'user', admin: false)}

  def login_admin
    visit root_path
    fill_in "email", with: "admin@admin.com"
    fill_in 'password', with: 'password'
    click_button 'Sign in'
    visit admin_stores_path
  end

  context 'when the current user is a platform admin' do
    it 'they can view an index of all current stores with their details' do
      login_admin
      expect(current_path).to eq admin_stores_path
    end

    context 'When a store is pending' do
      it 'they can approve the store' do
        login_admin
        within('tr#1') do
          page.should have_content 'Pending'
          click_button 'Approve'
        end
        page.should have_content 'Store updated successfully.'
        within('tr#1') do
          page.should have_content 'Active'
          page.should have_button 'Disable'
        end
      end

      it 'they can decline the store' do
        login_admin
        within('tr#1') do
          page.should have_content 'Pending'
          click_button 'Decline'
        end
        page.should have_content 'Store updated successfully.'
        expect( page ).to_not have_content 'tr#1'
      end
    end

    context 'and there is an approved store' do
      it 'they can disable the store' do
        login_admin
        within('tr#1') do
          click_button 'Approve'
        end
        within('tr#1') do
          page.should have_button 'Disable'
          click_button 'Disable'
        end
        page.should have_content 'Store updated successfully.'
        within('tr#1') do
          page.should have_content 'Disabled'
        end
      end
    end

    context 'and there is an inactive store' do
      it 'they can enable the store' do
        login_admin
        within('tr#1') do
          click_button 'Approve'
        end
        within('tr#1') do
          page.should have_button 'Disable'
          click_button 'Disable'
        end
        within('tr#1') do
          page.should have_button 'Enable'
          click_button 'Enable'
        end
        page.should have_content 'Store updated successfully.'
        within('tr#1') do
          page.should have_content 'Active'
        end
      end
    end
  end

  context 'when the user is not a platform admin' do
    it 'they cannot view the platform admin page' do
      visit '/'
      fill_in 'email', with: 'test@test.com'
      fill_in 'password', with: 'password'
      click_button 'Sign in'
      page.should_not have_content 'Admin'
      visit admin_stores_path
      expect(current_path).to eq "/stores"
    end
  end
end
