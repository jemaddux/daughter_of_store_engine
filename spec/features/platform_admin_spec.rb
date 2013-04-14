require 'spec_helper'

describe 'Platform Admin:' do

  let!(:store) {Store.create(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses')}
  let!(:admin) {Customer.create(username: 'admin', email: 'test@test.com', password: 'password', first_name: 'admin', last_name: 'user', admin: true)}
  let!(:user) {Customer.create(username: 'user', email: 'test2@test2.com', password: 'password', first_name: 'test', last_name: 'user', admin: false)}

  context 'when the current user is a platform admin' do
    it 'they can view an index of all current stores with their details' do
      visit '/'
      click_link 'Login / Signup'
      fill_in 'username', with: 'admin'
      fill_in 'password', with: 'password'
      click_button 'Login'
      click_link 'Admin'
      page.should have_content 'Stores Dashboard'
      page.should have_content 'Admin Access'
      page.should have_content 'Store URL'
      page.should have_content 'Description'
      page.should have_content 'Status'
    end

    context 'and there is a pending store' do
      it 'they can approve the store' do
        visit '/'
        click_link 'Login / Signup'
        fill_in 'username', with: 'admin'
        fill_in 'password', with: 'password'
        click_button 'Login'
        click_link 'Admin'
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

      it 'they can reject the store' do
        visit '/'
        click_link 'Login / Signup'
        fill_in 'username', with: 'admin'
        fill_in 'password', with: 'password'
        click_button 'Login'
        click_link 'Admin'
        within('tr#1') do
          page.should have_content 'Pending'
          click_button 'Reject'
        end
        page.should have_content 'Store updated successfully.'
        within('tr#1') do
          page.should have_content 'Declined'
          page.should have_button 'Approve'
        end
      end
    end

    context 'and there is an approved store' do
      it 'they can disable the store' do
        visit '/'
        click_link 'Login / Signup'
        fill_in 'username', with: 'admin'
        fill_in 'password', with: 'password'
        click_button 'Login'
        click_link 'Admin'
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

    context 'and there is a declined store' do
      it 'they can still approve the store' do
        visit '/'
        click_link 'Login / Signup'
        fill_in 'username', with: 'admin'
        fill_in 'password', with: 'password'
        click_button 'Login'
        click_link 'Admin'
        within('tr#1') do
          click_button 'Reject'
        end
        within('tr#1') do
          page.should have_button 'Approve'
          click_button 'Approve'
        end
        page.should have_content 'Store updated successfully.'
        within('tr#1') do
          page.should have_content 'Active'
        end
      end
    end

    context 'and there is an inactive store' do
      it 'they can enable the store' do
        visit '/'
        click_link 'Login / Signup'
        fill_in 'username', with: 'admin'
        fill_in 'password', with: 'password'
        click_button 'Login'
        click_link 'Admin'
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

  context 'when the current user is not a platform admin' do
    it 'they cannot view the platform admin page' do
      visit '/'
      click_link 'Login / Signup'
      fill_in 'username', with: 'user'
      fill_in 'password', with: 'password'
      click_button 'Login'
      page.should_not have_content 'Admin'
      visit '/admin/stores'
      page.should have_content 'Only system administrators may access this page'
    end
  end
end