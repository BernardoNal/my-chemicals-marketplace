class PurchasesController < ApplicationController
  private

  # Only allow a purchase of trusted parameters through.
  def purchase_params
    params.require(:purchase).permit(:product_id)
    # , :photo
  end
end
