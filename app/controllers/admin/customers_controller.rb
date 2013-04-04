class Admin::CustomersController < ApplicationController 
  layout 'admin/application.html.haml'

  before_filter :require_admin

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    redirect_to admin_customers_path
  end
end