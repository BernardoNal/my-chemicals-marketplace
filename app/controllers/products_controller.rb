class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    @product.save
    redirect_to product_path(@product)
  end
  
  def show
    @product = Product.find(params[:id])
  end

  def myproducts
    @products = current_user.products
  end

  private

  # Only allow a product of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :description)
    # , :photo
  end
end
