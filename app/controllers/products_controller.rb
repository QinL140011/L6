class ProductsController < ApplicationController
  def index
    @products = Product.all.order(created_at: :desc)
    @cart = current_cart
    @cart_items = @cart.cart_items.includes(:product)
    @total = @cart_items.sum { |i| i.product.price * i.qty }
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "商品を登録しました"
    else
      @error = @product.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to products_path, notice: "商品を削除しました"
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end