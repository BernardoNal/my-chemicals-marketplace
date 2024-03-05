class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @product = @cart_item.product

    if cart_item_params[:quantity].to_i <= @product.quantity
      if @cart_item.update(cart_item_params)
        redirect_to cart_path, notice: 'Cart item was successfully updated.'
      else
        render :edit
      end

    else
      redirect_to cart_path, notice: 'Unable to update cart item - not enough stock available.'
    end
  end

  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path, notice: 'Item was successfully removed from your cart.' }
      format.json { head :no_content }
    end
  end

  private

  def set_cart_item
    @cart_item = current_user.cart.cart_items.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
