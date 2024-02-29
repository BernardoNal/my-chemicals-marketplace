class PurchasesController < ApplicationController
  def create
    @purchase = Purchase.new()
    @data = Time.now
    @purchase.user = current_user
    @purchase.date_purchase = @data
    @purchase.product = Product.find(params[:product_id])

    if @purchase.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def mypurchases
    @purchases = current_user.purchases
  end

end
