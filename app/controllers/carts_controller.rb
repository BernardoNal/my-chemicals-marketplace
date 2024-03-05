class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_cart
  end

  def add_product_to_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    @cart = current_cart

    new_item = @cart.cart_items.find_or_initialize_by(product: product)

    new_item.quantity ||= 0
    new_item.quantity += quantity

    if new_item.quantity > product.quantity
      redirect_to product_path(product), alert: 'Not enough product quantity available.'
    elsif new_item.save
      redirect_to cart_path, notice: 'Product added to cart.'
    else
      redirect_to product_path(product), alert: 'There was a problem adding the product to the cart.'
    end
  end

  def purchase_items
    @cart = current_cart
    insufficient_stock = false

    ActiveRecord::Base.transaction do
      @cart.cart_items.each do |cart_item|
        @product = cart_item.product
        new_quantity = @product.quantity - cart_item.quantity

        if new_quantity.negative?

          insufficient_stock = true
          raise ActiveRecord::Rollback
        end

        @product.update!(quantity: new_quantity)
        Purchase.create!(user: current_user, product: @product, quantity: cart_item.quantity, date_purchase: Time.zone.now)
      end
      @cart.destroy!
    end

    if insufficient_stock

      flash[:alert] = 'Sorry, there was not enough stock for one or more products.'
      redirect_to cart_path
    else

      session[:cart_id] = nil

      redirect_to mypurchases_path, notice: 'Thank you for your purchase!'
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Purchase failed due to validation error: #{e.message}")
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
