class StoreAdmin::StoresController < ApplicationController
  layout 'admin/application'
  skip_filter :scope_current_store
  before_filter :require_store_admin

  #def index
  #  @store = Store.all
  #end

  def orders
    @store = Store.find_by_path(params[:store_path])

    if params[:status]
      @orders = @store.orders.where(status: params[:status]).all
    else
      @orders = @store.orders
    end

  end

  def show
    @store = Store.find_by_path(params[:store_path])
  end

  def edit
    @store = Store.find_by_path(params[:store_path])
  end


  def update
    @store = Store.find_by_path(params[:store_path])

    if @store.update_attributes(params[:store])
      redirect_to store_admin_path(@store.path), notice: 'Store was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @store = Store.find_by_path(params[:store_path])
    @store.destroy

    redirect_to store_admin_stores_url
  end

  def add_store_admin
    new_admin = Customer.find_by_email(params[:email])
    if new_admin.nil?
      Resque.enqueue(SignUpEmail, current_user.id, params[:email])
      notice = "User does not have an account, email sent to sign up"
    elsif new_admin.store_admin?(current_store)
      notice = "User is already an admin"
    else
      Store.include_admin(new_admin.id, current_store.id)
      Resque.enqueue(NewStoreAdminEmail, new_admin.id,current_store.id)
      notice = "User assigned as an admin"
    end
    redirect_to :back, notice: notice
  end

  def remove_store_admin
    store = Store.find_by_path(params[:store_path])
    customer = Customer.find(params[:id])
    if customer == current_user
      redirect_to :back, notice: "Cannot delete yo'self BIOTCH"
    else
      StoreAdmin.find_by_customer_id_and_store_id(customer.id,store.id).destroy
      Resque.enqueue(RemoveFromStoreEmail, customer.id,store.id)
      redirect_to :back, notice: "User removed. They have been notified."
    end
  end

  def add_store_stocker
    new_stocker = Customer.find_by_email(params[:email])
    if new_stocker.nil?
      Resque.enqueue(SignUpEmail, current_user.id, params[:email])
      notice = "User does not have an account, email invitation sent."
    elsif new_stocker.store_stocker?(current_store)
      notice = "User is already an stocker for your store."
    else
      Store.include_stocker(new_stocker.id, current_store.id)
      Resque.enqueue(NewStoreStockerEmail, new_stocker.id,current_store.id)

      notice = "User assigned as a stocker."
    end
    redirect_to :back, notice: notice
  end

  def remove_store_stocker
    store = Store.find_by_path(params[:store_path])
    customer = Customer.find(params[:id])
    if customer == current_user
      redirect_to :back, notice: "Cannot delete yo'self BIOTCH"
    else
      StoreStocker.find_by_customer_id_and_store_id(customer.id,store.id).destroy
      Resque.enqueue(RemoveFromStoreEmail, customer.id,store.id)
      redirect_to :back, notice: "User removed. They have been notified."
    end
  end

end
