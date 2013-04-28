require 'spec_helper'


describe Article do 

  let!(:admin) {Customer.create!(email: 'admin@admin.com', password: 'password', first_name: 'admin', last_name: 'user', admin: true)}
  let!(:user) {Customer.create!(email: 'user@user.com', password: 'password', first_name: 'user', last_name: 'user', admin: false)}
  let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')}

    def login_the_admin
      visit login_path
      fill_in 'email', with: 'admin@admin.com'
      fill_in 'password', with: 'password'
      click_button 'Login'
    end

  it '#new should be accessible to store admins' do
    login_the_admin
    visit store_admin_path(store)
    click_on 'New Blog Post'
    expect( current_path ).to eq new_article_path(store)
    expect(page).to have_field("article_title")
    expect(page).to have_field("article_body")
  end

  it '#create should save the new article to the DB' do 
    login_the_admin
    visit new_article_path(store)
    expect( current_path ).to eq new_article_path(store)
    fill_in "article_title", with: "New Blog Post Title"
    fill_in "article_body", with: "New Blog Post Body"
    click_on "save"
    expect(current_path).to eq article_path(store, Article.first)
    expect(page).to have_content "New Blog Post Title"
    expect(page).to have_content "New Blog Post Body"
  end

  it '#new should not be accessible to un-authenticated users' do
    visit new_article_path(store)
    expect(current_path).to eq home_path(store)
  end

  it '#edit should be accessible to store admins' do
    article = Article.create!(title: 'w', body: 'i', customer_id: admin.id, store_id: store.id)
    login_the_admin
    visit edit_article_path(store, article)
    expect( current_path ).to eq edit_article_path(store, article)
    expect(page).to have_field("article_title")
    expect(page).to have_field("article_body")
  end
  it '#edit should not be accessible to unauthenticated users' do
    article = Article.create!(title: 'w', body: 'i', customer_id: admin.id, store_id: store.id)
    visit edit_article_path(store, article)
    expect(current_path).to eq home_path(store)
  end

  it '#delete should only be accessible to store admins' do
    article = Article.create!(title: 'w', body: 'i', customer_id: admin.id, store_id: store.id)
    login_the_admin
    visit edit_article_path(store, article)
    click_on "Delete"
    expect( current_path).to eq store_admin_path(store)
    expect(Article.count).to eq 0
  end

  it '#show should be accessible to all users' do
    article = Article.create!(title: 'w', body: 'i', customer_id: admin.id, store_id: store.id)
    visit article_path(store, article)
    expect(page).to have_content('w') 
  end
    
  it '#index should be accessible to all users' do
    
  end

end
