require 'spec_helper'

describe 'Admin/Store' do
  let!(:admin) {Customer.create!(email: 'admin@admin.com', password: 'password', first_name: 'admin', last_name: 'user', admin: true)}
  let!(:user) {Customer.create!(email: 'user@user.com', password: 'password', first_name: 'user', last_name: 'user', admin: false)}
  let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')}

  def login_the_admin
    visit login_path
    fill_in 'email', with: 'admin@admin.com'
    fill_in 'password', with: 'password'
    click_button 'Login'
  end

  context "#edit" do 
    it "should have ability to upload image" do 
      login_the_admin
      visit store_admin_edit_store_path(store)
      expect(current_path).to eq store_admin_edit_store_path(store)
      expect( page ).to have_button 'Upload Background Image'
    end

    it 'see all images that have been uploaded' do
      file = File.open("./app/assets/images/products/boat_water.jpg")
      image = BackgroundImage.new(photo: file)
      image.store_id = store.id
      image.save

      login_the_admin
      visit store_admin_edit_store_path(store)
      expect( page ).to have_content store.name
      page.should have_css('#background-image-0')
    end

    it "should be able to delete an image" do 
      file = File.open("./app/assets/images/products/boat_water.jpg")
      image = BackgroundImage.new(photo: file)
      image.store_id = store.id
      image.save
      login_the_admin
      visit store_admin_edit_store_path(store)
      within("#background-images") do 
        click_on "Delete"
      end
      expect(current_path).to eq store_admin_edit_store_path(store)
    end


    it "should be able to change title"
    it "should be able to change description"
    it "should be able to change background color"
    it "should be able to change font color"
    it "should be able to change font button color"

  end
end
