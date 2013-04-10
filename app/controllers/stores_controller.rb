class StoresController < ApplicationController
  skip_filter :scope_current_store, only: [:index, :new]

  def index
    @stores = Store.unscoped.all
    render layout: "layouts/index"
  end
  
  def show
    @store = current_store
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
      redirect_to @store, notice: 'Store was successfully created.'
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
