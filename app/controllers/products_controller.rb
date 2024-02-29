class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path, status: :see_other
  end

  private




  # Only allow a product of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :description)
    # , :photo
  end
end
