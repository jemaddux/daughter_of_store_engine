class Admin::StoresController < ApplicationController
  skip_filter :scope_current_store
  before_filter :require_admin


  def index
    @stores = Store.unscoped.all( :order => "created_at DESC")
  end

  def show
    @store = Store.find(params[:id])
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])

    if @store.update_attributes(params[:admin_store])
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    redirect_to admin_stores_url
  end
end
