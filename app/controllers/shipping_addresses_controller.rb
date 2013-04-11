class ShippingAddressesController < ApplicationController
  before_filter :require_login
  skip_filter :scope_current_store

  def show
    @shipping_address = current_user.shipping_address
    render layout: "layouts/landing"
  end

  def new
    @shipping_address = ShippingAddress.new
    render layout: "layouts/landing"
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
    render layout: "layouts/landing"
  end

  def create
    @shipping_address = ShippingAddress.new(params[:shipping_address])

    if @shipping_address.save
      redirect_to @shipping_address,
      notice: 'Shipping address was successfully created.'
    else
      redirect_to :back, notice: "Invalid shipping address"
    end
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])

    if @shipping_address.update_attributes(params[:shipping_address])
      redirect_to shipping_address_path(@shipping_address),
      notice: 'Shipping address was successfully updated.'
    else
      redirect_to edit_shipping_address_path(@shipping_address)
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy

    redirect_to customer_path(current_user.id)
  end
end
