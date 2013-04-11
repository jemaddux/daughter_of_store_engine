class StoresController < ApplicationController
  skip_filter :scope_current_store, only: [:landing, :index, :new, :create]

  def landing
    render layout: "layouts/landing"
  end

  def index
    if current_user == nil
      redirect_to root_path
    elsif current_user.admin == true
      @stores = Store.unscoped.all
      render layout: "layouts/landing"
    else
      redirect_to root_path, notice:"You don't belong here"
    end
  end
  
  def show
    @store = current_store
    session[:shopping_cart][current_store.id] ||= Hash.new(0)
  end

  def new
    @store = Store.new
    render layout: "layouts/landing"
  end

  def edit
    @store = current_store
  end

  def create
    @store = Store.new(params[:store])

    if @store.save
      redirect_to home_path(@store), notice: 'Thank you. Your store is currently pending acceptance'
    else
      render action: "new"
    end
  end

  def update
    @store = Store.find(params[:id])

    if @store.update_attributes(params[:store])
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    redirect_to stores_url
  end
end
