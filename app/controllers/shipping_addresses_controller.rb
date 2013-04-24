class ShippingAddressesController < ApplicationController
  before_filter :require_login
  skip_filter :scope_current_store

  def show
    @shipping_address = ShippingAddress.find_by_customer_id(current_user.id)
  end

  def new
    @shipping_address = ShippingAddress.new
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def create
    @shipping_address = ShippingAddress.new(city: params[:shipping_address][:city],
          phone: shorten_phone(params[:shipping_address][:phone]),
          state: params[:shipping_address][:state],
          street: params[:shipping_address][:street],
          zipcode: params[:shipping_address][:zipcode],
          customer_id: current_user.id)

    if @shipping_address.save
      redirect_back_or_to @shipping_address,
      notice: 'Shipping address was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @shipping_address = ShippingAddress.find_by_customer_id(current_user.id)

    if @shipping_address.update_attributes(city: params[:shipping_address][:city],
                                           phone: shorten_phone(params[:shipping_address][:phone]),
                                           state: params[:shipping_address][:state],
                                           street: params[:shipping_address][:street],
                                           zipcode: params[:shipping_address][:zipcode],
                                           customer_id: current_user.id)

      redirect_back_or_to shipping_address_path(@shipping_address),
      notice: 'Shipping address was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find_by_customer_id(current_user.id)

    redirect_to customer_path(current_user.id)
  end

  private

  def shorten_phone(number)
    return number.gsub("(","").gsub(")","").gsub("-","")
  end
end
