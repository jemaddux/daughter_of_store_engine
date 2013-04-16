class StoreAdmin::StoresController < ApplicationController
  skip_filter :scope_current_store

  #def index
  #  @store = Store.all
  #end

  def show
    @store = Store.find_by_path(params[:store_path])
  end


  def edit
    @store = Store.find_by_path(params[:store_path])
  end


  def update
    @store = Store.find_by_path(params[:store_path])

    if @store.update_attributes(params[:store])
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @store = Store.find_by_path(params[:store_path])
    @store.destroy

    redirect_to store_admin_stores_url
  end
end
