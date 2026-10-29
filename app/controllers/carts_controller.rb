class CartsController < ApplicationController
  def show
    @cart = current_cart
    @cart_items = @cart.cart_items.includes(:product)
    @total = @cart_items.sum { |i| i.product.price * i.qty }
  end
end