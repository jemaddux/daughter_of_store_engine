class CreditCardsController < ApplicationController
  before_filter :require_login
  skip_filter :scope_current_store

  def show
    @credit_card = CreditCard.find_by_customer_id(current_user.id)
  end

  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = CreditCard.new(brand: params[:credit_card][:brand],
                                  cardholder_name: params[:credit_card][:cardholder_name],
                                  number: params[:credit_card][:number],
                                  expiration_date: params[:credit_card][:expiration_date],
                                  cvc: params[:credit_card][:cvc],
                                  customer_id: current_user.id)

    if @credit_card.save
      redirect_back_or_to credit_card_path(@credit_card),
      notice: 'Credit Card was successfully saved.'
    else
      render action: 'new'
    end
  end

  def edit
    @credit_card = CreditCard.find_by_customer_id(current_user.id)
  end

  def update
    @credit_card = CreditCard.find_by_customer_id(current_user.id)

    if @credit_card.update_attributes(brand: params[:credit_card][:brand],
                                      cardholder_name: params[:credit_card][:cardholder_name],
                                      number: params[:credit_card][:number],
                                      expiration_date: params[:credit_card][:expiration_date],
                                      cvc: params[:credit_card][:cvc],
                                      customer_id: current_user.id)
      redirect_back_or_to credit_card_path(@credit_card),
                          notice: 'Credit Card was successfully updated.'
    else
      render action: 'edit'
    end
  end
end
