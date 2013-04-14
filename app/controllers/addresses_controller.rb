class AddressesController < ApplicationController
  skip_filter :scope_current_store

  def create
    @address = Address.new(params[:address])

    if @address.save
      redirect_back_or_to @address,
      notice: "Address was successfully created."
    else
      render action: 'new'
    end
  end

end
