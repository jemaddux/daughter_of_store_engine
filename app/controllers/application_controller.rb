class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :shopping_cart
  around_filter :scope_current_store, except: [:request_login]
  helper_method :category_list



  def category_list
    Category.all
  end

  def not_authenticated
    redirect_to login_url
  end

  def require_admin
    if !current_user || current_user.admin != true
      redirect_to root_path, :notice => "Only system administrators may access this page"
    else
      true
    end
  end

  def require_store_admin
    unless current_user.store_admin?(current_store)
      redirect_to home_path(current_store), notice:"Only store administrators may access this page"
    end
  end
    # admin_ids = Store.find(current_store.id).store_admins.collect { |s| s.id }
    # if !current_user || !admin_ids.include?(current_user.id)
    #   redirect_to home_path(params[:store_path]), :notice => "Only store administrators may access this page"
    # else
    #   true
    # end

  def request_login
    if logged_in?
      true
    else
      session[:return_to_url] = request.url if Config.save_return_to_url && request.get?
      redirect_to login_path, notice: "Please log in to your account. "
      return
    end
  end

  def current_store
    @current_store ||= Store.find_by_path(params[:store_path])
  end

  helper_method :current_store

  private

  def scope_current_store
    Store.current_id = current_store.id
    yield
  ensure
    Store.current_id = nil
  end

  def shopping_cart
    session[:shopping_cart] ||= {}
    shopping_cart_for_store
    if logged_in?
      if current_user.cart
        unless session[:shopping_cart] == current_user.cart.data
          session[:shopping_cart] = current_user.cart.data.merge(session[:shopping_cart])
          current_user.cart.update_attributes(data: session[:shopping_cart])
        end
      else
        current_user.create_cart(data: session[:shopping_cart])
      end
    end
  end
  
  def shopping_cart_for_store
    if current_store
      session[:shopping_cart][current_store.id] ||= Hash.new(0)
    end
  end 

end

