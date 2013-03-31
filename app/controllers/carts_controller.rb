class CartsController < ApplicationController
  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    @cart = Cart.find_or_create_by_id(session[:cart_id])

    @products = @cart.products

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(params[:cart])
    @customer = Customer.find_or_create(session[:id])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @cart = Cart.find_or_create_by_id(session[:cart_id])
    # @cart = Cart.create if @cart.nil?

    session[:cart_id] = @cart.id

    
    # if logged_in?
    #   if current_user.cart != nil
    #     @cart = current_user.cart
    #   else
    #     @cart = Cart.create(customer_id: current_user.id)
    #   end
    # else
    #   @cart = Cart.create
    #   cookies[:cart] = @cart.id
    # end
    
    product  = Product.find(params[:product])
    quantity = params[:quantity].to_i
    product_price    = quantity * product.price

    if @cart.products.include?(product)
      cart_product = @cart.cart_products.find_by_product_id(params[:product])
      cart_product.update_attributes(quantity: quantity, price: product_price)
    else
      @cart.products << product

      cart_product = @cart.cart_products.find_by_product_id(params[:product])
      cart_product.update_attributes(quantity: quantity, price: product_price)
    end

    cart_total = @cart.cart_products.collect{ |cart_product| cart_product.price }.reduce(:+)
    @cart.total = cart_total

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url }
      format.json { head :no_content }
    end
  end
end
