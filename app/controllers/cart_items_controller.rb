class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:destroy]

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
end
