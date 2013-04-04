class CustomerSessionsController < ApplicationController
  def new
  end

  def create
    if login(params[:username], params[:password])
      if current_user.admin
        redirect_back_or_to( admin_products_path,
          message: 'Logged in successfully.')
      else
        redirect_back_or_to( root_path,
          message: 'Logged in successfully.')
      end
    else
      flash.now.alert = "Login failed."
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to( root_path, message: 'Logged out!')
  end
end