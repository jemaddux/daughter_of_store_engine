class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :shopping_cart
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

  def request_login
    #if logged_in?

    #check for shipping
    #if shipping
    #else
    #redirect to create shipping
    #end

    #else
    #ask if they want to login?
    #ask if they want to create account
    #offer guest checkout page
    #end

    unless current_user
      #ask if they want to login?
      #ask if they want to create account
      #offer guest checkout page


      session[:return_to_url] = request.url if Config.save_return_to_url && request.get?
      self.send(Config.not_authenticated_action)

      redirect_to login_path, flash: "Want to checkout as a guest? #{link_to , "Click Here"}"
      link_to("\##{ht[:text]}", "www.url.com"

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

  def shopping_cart
    session[:shopping_cart] ||= {}
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

end
