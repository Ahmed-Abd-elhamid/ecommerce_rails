class CartsController < ApplicationController
  
  def index
    @carts = Cart.all
  end

  def show
    @cart = Cart.find(params[:id])
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new()
    @cart.quantity = 2
    @cart.user_id = 1 #current_user_id
    @cart.product_id = params[:id]
    if @cart.save
      redirect_to @cart
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def cart_params
      params.require(:product).permit(:id, :quantity, :price, :quantity, :product_id, :user_id)
  end
end