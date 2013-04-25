require 'spec_helper'

describe BackgroundImage do 
  context "uploading an image" do 
    let!(:store) {Store.create!(name: 'Cool Sunglasses', path: 'cool-sunglasses', description: 'We have cool sunglasses', status: 'active')}
    
    it "#new should exist" do 
      visit new_background_image_path(store)
      expect(page).to have_button "Create Background image"
    end

    it "#create should upload a photo" do 
      visit new_background_image_path(store)
      
      expect(page).to have_button "Create Background image"
    end
  end

end
