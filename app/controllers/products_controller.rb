class ProductsController < ApplicationController
  private

  # Only allow a product of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :description)
    # , :photo
  end
end
