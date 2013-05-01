class CustomersController < ApplicationController
  before_filter :require_login, except: [:new, :create]
  skip_filter :scope_current_store

  def show
    @customer = Customer.find(current_user.id)
  end

  def new
    session[:redirect_after_create] = params[:path]
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find(current_user.id)
  end

  def create
    @customer = Customer.new(params[:customer])

    if @customer.save
      auto_login(@customer)
      @customer.welcome_email
      if session[:redirect_after_create]
        redirect_to session[:redirect_after_create],
          notice: "<a href='/account'>Edit your details</a>".html_safe
      else
        redirect_back_or_to account_path, notice: 'Thanks for signing up.'
      end
    else
      render action: 'new'
    end
  end

  def update
    @customer = Customer.find(current_user.id)
    if @customer.update_attributes(params[:customer])
      redirect_to customers_path, notice: 'Customer was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    redirect_to customers_url
  end
end
