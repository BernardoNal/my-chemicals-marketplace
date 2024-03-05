class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    if params[:search].present? && params[:search][:query].present?
      @products = Product.where("name ILIKE :query OR description ILIKE :query", query: "%#{params[:search][:query]}%")
    else
      @products = Product.all
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to myproducts_products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
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
      redirect_to myproducts_products_path
      flash[:alert] = "Product edited successfully."
    else
      render :edit
    end
  end

  def myproducts
    @products = current_user.products
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to myproducts_products_path, status: :see_other
  end

  private

  # Only allow a product of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :description, :quantity, :photo)
  end
end
