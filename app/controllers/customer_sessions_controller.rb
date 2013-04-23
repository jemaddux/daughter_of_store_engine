class CustomerSessionsController < ApplicationController
  skip_filter :scope_current_store

  def new
    if params[:path]
      session[:redirect_after_create] = params[:path]
    end
  end

  def create
    if login(params[:email], params[:password])
      if current_user.admin
        redirect_back_or_to admin_stores_path, message: 'Logged in successfully.'
      else
        if session[:redirect_after_create]
          redirect_to session[:redirect_after_create], notice: 'Logged in!'
        else
          redirect_back_or_to root_path, notice: 'Logged in!'
        end
      end
    else
      session[:redirect_after_create] = nil
      flash.now.notice = 'Email or password invalid'
      render action: 'new'
    end
  end

  def destroy
    logout
    session[:return_to_url] = nil
    redirect_to :back, notice: "Logged out!"
  end
end
