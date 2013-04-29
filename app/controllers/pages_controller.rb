class PagesController < ApplicationController
  before_filter :require_store_admin_or_admin, except: :show
  def index
    redirect_to home_path(current_store)
  end

  def show
    page = Page.find(params[:id])
    if page.store_id == current_store.id
      @page = page
    else
      redirect_to home_path(current_store), notice:"invalid page"
    end
  end

  def new
    @page = Page.new
  end

  def edit
    page = Page.find(params[:id])
    if page.store_id == current_store.id
      @page = page
    else
      redirect_to store_admin_path(current_store), notice:"invalid page"
    end
  end


  def create
    @page = Page.new(params[:page])
    @page.store_id = current_store.id

    if @page.save
      redirect_to page_path(current_store, @page),
              notice: 'Page was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(params[:page])
      @page.store_id = current_store.id
      @page.save
      redirect_to page_path(current_store, @page),
              notice: 'Page was successfully updated.'
    else
     render action: "edit"
    end
  end

  def destroy
    page = Page.find(params[:id])
    if page.store_id == current_store.id
      page.destroy
    else
      redirect_to store_admin_path(current_store),
              notice: "cannot delete that page"
    end
    redirect_to store_admin_path(current_store)
  end
end
