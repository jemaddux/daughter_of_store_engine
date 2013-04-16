class Admin::StoresController < ApplicationController
  skip_filter :scope_current_store
  before_filter :require_admin


  def index
    @stores = Store.unscoped.all( :order => "created_at DESC")
  end

  def administer
    platform_admin = current_user
    store_admin = Customer.find(params[:admin_id])
    logout

    session[:platform_admin] = "true"
    session[:platform_admin_id] = platform_admin.id
    
    auto_login(store_admin)
    
    redirect_to home_path(current_store)
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
