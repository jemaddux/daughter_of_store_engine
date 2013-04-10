class ApplicationController < ActionController::Base
  protect_from_forgery

  around_filter :scope_current_store

  helper_method :category_list

  def category_list
    Category.all
  end

  def not_authenticated
    redirect_to login_url
  end

  def require_admin
    if logged_in?
      redirect_to login_url unless current_user.admin
    else
      redirect_to login_url
    end
  end

  def current_store
    Store.find_by_path(params[:store_path])
  end

  helper_method :current_store

  private

  def scope_current_store
    Store.current_id = current_store.id
    yield
  ensure
    Store.current_id = nil
  end

end