class StoresController < ApplicationController
  skip_filter :scope_current_store, only: [:landing, :index, :new, :create, :update, :change_status]
  before_filter :require_login, only: [:new]

  def landing
    if logged_in?
      redirect_to stores_path
    else
      render :layout => "landing"
    end
  end

  def index
    @stores = Store.unscoped.all
  end
  
  def show
    store ||= current_store
    if store.status == "pending"
      render :inline => "This store is pending"
    else
      @store = store
      session[:shopping_cart][@store.id] ||= Hash.new(0)
    end
  end

  def new
    @store = Store.new
  end

  def edit
    @store = current_store
  end

  def create
    @store = Store.new(params[:store])

    if @store.save
      StoreAdmin.create(customer_id: current_user.id, store_id: @store.id)
      redirect_to store_admin_store_path(@store.id), notice: 'Thank you. Your store is currently pending acceptance'
    else
      render action: 'new'
    end
  end

  def update
    @store = Store.find_by_path(params[:id])

    if @store.update_attributes(params[:store])
      redirect_to admin_path(@store.path), notice: 'Store was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    redirect_to stores_url
  end

  def change_status
    store = Store.find(params[:id])
    
    store.update_attribute(:status, params[:status])
    
    Resque.enqueue(SendStatusEmail, store.id)

    redirect_to admin_stores_path, notice: 'Store updated successfully.'
  end


end
