require 'spec_helper'

describe Page do


  describe 'authenticated store_admin user' do
    let!(:admin) {Customer.create!(email: 'admin@admin.com', password: 'password', first_name: 'admin', last_name: 'user', admin: true)}
    let!(:user) {Customer.create!(email: 'user@user.com', password: 'password', first_name: 'user', last_name: 'user', admin: false)}
    let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')}
    title = "About"
    slug = title.parameterize
    body = "Our store is great, we have the best sunglasses"
      def login_the_admin
        visit login_path
        fill_in 'email', with: 'admin@admin.com'
        fill_in 'password', with: 'password'
        click_button 'Login'
      end

      it "should be able to create a page" do
        login_the_admin
        visit new_page_path(store)
        fill_in 'page_title', with: title
        fill_in 'page_body', with: body
        click_on 'save'
        expect(page).to have_content title
        expect(page).to have_content body
      end

      it "should be able to edit" do
        login_the_admin
        visit new_page_path(store)
        fill_in 'page_title', with: title
        fill_in 'page_body', with: body
        click_on 'save'
        post = Page.first
        expect(current_path).to eq page_path(store, post)
        visit edit_page_path(store, post)
        fill_in 'page_title', with: 'History'
        fill_in 'page_body', with: body
        click_button 'update'
        expect(page).to have_content "History"
        expect(current_path).to have_content "history"
      end

      it "should only edit their own pages" do
        page = Page.create!(title:title, body: body, slug: slug, store_id: 5)
        login_the_admin
        visit store_admin_path(store)
        within("#store-pages") do
          expect(page).to_not have_content 'Delete'
        end
      end
  end

  describe 'unauthenticated user' do

    title = "About"
    slug = title.parameterize
    body = "Our store is great, we have the best sunglasses"

    it "should see pages" do
      store = Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')
      about = Page.create!(
        title: title,
        slug: slug,
        body: body,
        store_id: store.id)

      visit page_path(store,about)
      expect(current_path).to eq page_path(store,about)
      expect(page).to have_content title
      expect(page).to have_content body
    end


    it "should not be able to edit" do
      store = Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')
      about = Page.create!(title: title, slug: slug, body: body, store_id: store.id)
      visit edit_page_path(store,about)
      expect(current_path).to eq home_path(store)
    end
  end



end
