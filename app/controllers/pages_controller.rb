class PagesController < ApplicationController
  layout 'admin/application', except: [:show]
  before_filter :require_store_admin_or_admin, except: :show
  def index
    redirect_to home_path(current_store)
  end

  def show
    @page = current_store.pages.find_by_slug(params[:id])
  end

  def new
    @page = Page.new
  end

  def edit
    @page = current_store.pages.find_by_slug(params[:id])
  end


  def create
    @page = current_store.pages.new(params[:page])
    @page.create_slug

    if @page.save
      redirect_to page_path(current_store, @page),
              notice: 'Page was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @page = current_store.pages.find_by_slug(params[:id])

    if @page.update_attributes(params[:page])
      @page.create_slug
      @page.save
      redirect_to page_path(current_store, @page),
              notice: 'Page was successfully updated.'
    else
     render action: "edit"
    end
  end

  def destroy
    page = current_store.pages.find_by_slug(params[:id])
    page.destroy
    redirect_to store_admin_path(current_store) 
  end
end
