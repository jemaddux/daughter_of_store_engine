class ShippingAddressesController < ApplicationController
  before_filter :require_login

  def show
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def new
    @shipping_address = ShippingAddress.new
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def create
    @shipping_address = ShippingAddress.new(params[:shipping_address])

    if @shipping_address.save
      redirect_to @shipping_address, notice: 'Shipping address was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])

    if @shipping_address.update_attributes(params[:shipping_address])
      redirect_to @shipping_address, notice: 'Shipping address was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy

    redirect_to shipping_addresses_url
  end
end
