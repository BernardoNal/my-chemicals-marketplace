class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @products = Product.all
  end

  private

  # Only allow a product of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :description)
    # , :photo
  end
end
