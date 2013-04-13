class StoreAdmin::StoresController < ApplicationController
  skip_filter :scope_current_store

  def index
    @store = Store.all
  end

  def show
    @store = Store.find(params[:id])
  end


  def edit
    @store = Store.find(params[:id])
  end


  def update
    @store = Store.find(params[:id])

    if @store.update_attributes(params[:store])
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    redirect_to store_admin_stores_url
  end
end
