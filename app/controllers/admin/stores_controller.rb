class Admin::StoresController < ApplicationController
  skip_filter :scope_current_store
  before_filter :require_admin

  def index
    @stores = Store.unscoped.all
    render layout: "layouts/landing"
  end

  def show
    @store = Store.find(params[:id])
    render layout: "layouts/landing"
  end

  def edit
    @store = Store.find(params[:id])
    render layout: "layouts/landing"
  end

  def update
    @store = Store.find(params[:id])

    if @store.update_attributes(params[:admin_store])
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    redirect_to admin_stores_url
  end
end
