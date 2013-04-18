class AddressesController < ApplicationController
  before_filter :require_login
  skip_filter :scope_current_store

  def show
    @address = current_user.address
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address])

    if @address.save
      redirect_back_or_to address_path(current_user.id),
      notice: 'Billing Address was successfully saved.'
    else
      render action: 'new'
    end
  end

  def edit
    @address = Address.find_by_customer_id(current_user.id)
  end

  def update
    @address = Address.find(params[:id])

    if @address.update_attributes(params[:address])
      redirect_back_or_to shipping_address_path(@address),
                          notice: 'Billing address was successfully updated.'
    else
      render action: 'edit'
    end
  end
end
