class CartsController < ApplicationController
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html
      format.json { render json: @carts }
    end
  end

  def show
    @cart = Cart.find_or_create_by_id(session[:cart_id])

    @products = @cart.products

    respond_to do |format|
      format.html
      format.json { render json: @cart }
    end
  end

  def new
    @cart = Cart.new

    respond_to do |format|
      format.html
      format.json { render json: @cart }
    end
  end

  def edit
    @cart = Cart.find(params[:id])
  end

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

    session[:cart_id] = @cart.id
    
    product = Product.find(params[:product])

    @cart.add(product, params[:quantity].to_i)

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: "Your cart was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Your cart was successfully cleared." }
      format.json { head :no_content }
    end
  end
end
