require 'spec_helper'

describe Article do
  describe 'valid article' do
    
    it "shouldn't be created without a title" do
      article = Article.create(body: "Hi", customer_id: 1, store_id: 1)
      expect(article).to be_invalid
    end
    
    it "shoudln't be created without a body" do
      article = Article.create(title: 'article', customer_id: 1, store_id: 1)
      expect(article).to be_invalid
    end

    it "shouldn't be created without a store" do
      article = Article.create(title: 'article', body: 'Hi', customer_id: 1)
      expect(article).to be_invalid
    end

    it "shouldn't be created without a customer" do
      article = Article.create(title: 'Article', body: 'Hi', store_id: 1)
      expect(article).to be_invalid
    end
  end
end
