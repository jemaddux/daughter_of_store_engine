class StoreAdmin::StoresController < ApplicationController
  skip_filter :scope_current_store
  before_filter :require_store_admin

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
    fail
    new_admin = Customer.find_by_email(params[:email])
    if new_admin.nil?

      #send fancy email that invites them to create a new account for that particular store
      Resque.enqueue(SignUpEmail, store.id, email)

      redirect_to :back, notice: "User does not have an account, email sent to sign up"
    elsif new_admin.store_admin?(current_store)
      redirect_to :back, notice: "User is already an admin"
    else
      Store.include_admin(new_admin.id, current_store.id)
      Resque.enqueue(NewStoreAdminEmail, new_admin.id,store.id)

      redirect_to :back, notice: "User assigned as an admin"
    end
  end

  def remove_store_admin
  end
end
