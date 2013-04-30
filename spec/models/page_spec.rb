require 'spec_helper'

describe Page do
  let(:title) {"Valid Title"}
  let(:slug) {title.parameterize}
  let(:body) {"Valid Body"}

  describe 'validations' do

    it 'should be invalid without a title' do
      about = Page.create(body: body, slug: slug)
      expect(about).to be_invalid
    end
    
    it 'should be invalid without a body' do
      about = Page.create(title: title, slug: slug)
      expect(about).to be_invalid
    end

    it 'should be invalid without a slug' do
      about = Page.create(title: title, body: body)
      expect(about).to be_invalid
    end
    
    it 'should have a title, body, and slug to be valid' do
      about = Page.create(title: title, body: body, slug: slug)
      expect(about).to be_valid
    end
  end

  describe '#create_slug' do 
    it "should parameterize the title" do 
      about = Page.new(title: title, body: body)
      about.create_slug
      expect(about.slug).to eq about.title.parameterize
    end
  end

end
