class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_cart
  end

  def add_product_to_cart
    product = Product.find(params[:product_id])
    @cart = current_cart

    new_item = @cart.cart_items.build(product: product)

    if new_item.save
      redirect_to cart_path, notice: 'Product added to cart.'
    else
      redirect_to product, alert: 'There was a problem adding the product to the cart.'
    end
  end

  def purchase_items
    @cart = current_cart
    cart_items = @cart.cart_items

    ActiveRecord::Base.transaction do
      cart_items.each do |cart_item|
        Purchase.create!(user: current_user, product: cart_item.product, date_purchase: Time.zone.now)
      end
      @cart.destroy
    end
    session[:cart_id] = nil
    redirect_to mypurchases_path, notice: 'Thank you for your purchase!'
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Purchase failed: #{e.message}")
    flash[:alert] = 'Sorry, there was a problem with your purchase.'
    redirect_to cart_path
  end

  def destroy
    @cart = current_cart
    if @cart
      @cart.destroy
      session[:cart_id] = nil
      redirect_to root_path, notice: 'Cart emptied successfully.'
    else
      redirect_to root_path, alert: 'No cart found to empty.'
    end
  end

  private

  def current_cart
    current_user.cart ||= Cart.create(user: current_user)
  end
end
