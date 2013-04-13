class CustomerSessionsController < ApplicationController
  skip_filter :scope_current_store

  def new
  end

  def create
    if login(params[:username], params[:password])
      if current_user.admin
        redirect_back_or_to stores_path, message: 'Logged in successfully.'
      else
        redirect_back_or_to root_path, message: 'Logged in!'
      end
    else
      flash.now.notice = 'Username or password invalid'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to :back, notice: "Logged out!"
  end
end
