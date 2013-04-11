class CustomerSessionsController < ApplicationController
  skip_filter :scope_current_store

  def new
    render layout: "layouts/landing"
  end

  def create
    if login(params[:username], params[:password])
      if current_user.admin
        redirect_back_or_to( admin_products_path,
          message: 'Logged in successfully.')
      else
        redirect_back_or_to root_path, message: 'Logged in!'
      end
    else
      flash.now.alert = "Login failed."
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to :back, notice: "Logged out!"
  end
end
