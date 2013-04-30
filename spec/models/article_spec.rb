require 'spec_helper'

describe Article do
  title = "Article Title"
  body = "Article Body"
  customer_id = 1
  store_id = 1

  describe 'valid article' do
    it "shouldn't be valid without a title" do
      article = Article.create(body: body, customer_id: customer_id, store_id: store_id)
      expect(article).to be_invalid
    end
    
    it "shoudln't be valid without a body" do
      article = Article.create(title: title, customer_id: customer_id, store_id: store_id)
      expect(article).to be_invalid
    end

    it "shouldn't be valid without a store" do
      article = Article.create(title: title, body: body, customer_id: customer_id)
      expect(article).to be_invalid
    end

    it "shouldn't be valid without a customer" do
      article = Article.create(title: title, body: body, store_id: store_id)
      expect(article).to be_invalid
    end
  end

  describe '#increase_view_count' do 
    it "should increase the view_count attribute by 1" do 
      article = Article.create(
        title: title, 
        body: body, 
        customer_id: customer_id, 
        store_id: store_id
        )
      before_count = article.view_count
      article.increase_view_count
      expect(article.view_count).to eq before_count + 1
    end
  end
end
