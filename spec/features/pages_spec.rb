require 'spec_helper'

describe 'Page' do
  
  
  describe 'authenticated user' do
    let!(:admin) {Customer.create!(email: 'admin@admin.com', password: 'password', first_name: 'admin', last_name: 'user', admin: true)}
    let!(:user) {Customer.create!(email: 'user@user.com', password: 'password', first_name: 'user', last_name: 'user', admin: false)}
    let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')}

    context 'store admin' do
      def login_the_admin
        visit login_path
        fill_in 'email', with: 'admin@admin.com'
        fill_in 'password', with: 'password'
        click_button 'Login'
      end

      it "should be able to create" do
        login_the_admin
        visit new_page_path(store)
        fill_in 'Title', with: 'About'
        fill_in 'Body', with: 'Our store is great, we have the best sunglasses' 
        click_button 'Create'
        expect(page).to have_content('Our store is great')
      end

      it "should be able to edit" do 
        page = Page.create!(title:"About", body:"this is about our store", store_id: store.id)
        login_the_admin
        visit edit_page_path(store, page)
        expect(current_path).to eq edit_page_path(store,page)
        fill_in 'Title', with: 'History'
        fill_in 'Body', with: 'Our store is great, we have the best sunglasses' 
        click_button 'Update Page'
        expect(page).to have_content "History"
      end

      it "should be able to delete" do 
        page = Page.create!(title:"About", body:"this is about our store", store_id: store.id)
        login_the_admin
        visit page_path(store, page)
        click_button 'Delete'
      end

      it "should only edit their own pages"
      it "should be able to edit from the store's admin edit page"
    end
  end

  describe 'unauthenticated user' do
    it "should see new pages path"
    it "should not be able to edit"
  end
  


end