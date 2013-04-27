require 'spec_helper'

describe Page do

  describe 'validations' do

    it 'should have a title' do
      about = Page.create(:title => "About", :body => "This is what our site does")
      expect(about).to be_valid
    end
    it 'should be invalid without a title' do
      about = Page.create(:body => "This is what our site does")
      expect(about).to be_invalid
    end

    it 'should have a body' do
      about = Page.create(:title => "About", :body => "This is what our site does")
      expect(about).to be_valid
    end
    
    it 'should be invalid without a body' do
      about = Page.create(:title => "About")
      expect(about).to be_invalid
    end
  end
end
