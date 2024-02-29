class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show edit update]
  
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.purchases.count.positive?
      flash[:alert] = "Product has already been purchased and cannot be edited."
    end
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  private

  # Only allow a product of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :description)
    # , :photo
  end
end
