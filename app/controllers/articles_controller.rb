class ArticlesController < ApplicationController
  layout 'admin/application', except: [:show, :index]

  before_filter :require_store_admin_or_admin, except: [:show, :index]

  def index
    @articles = current_store.articles.order("created_at DESC").includes(:customer)
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    article = Article.new(store_id:current_store.id, customer_id: current_user.id)
    article.update_attributes(params[:article])
    if article.save
      redirect_to article_path(current_store, article)
    else
      render :new
    end
  end

  def update
    article = Article.find(params[:id])
    article.update_attributes(params[:article])
    if article.save
      redirect_to article_path(current_store, article)
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
    @article.increase_view_count  
  end

  def increase_view_count
    
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to store_admin_path(current_store) 
  end
end
