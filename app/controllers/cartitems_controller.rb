class CartitemsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @cart_item = CartItem.new
  end

  def create
    product_id = params[:product_id].to_i
    qty = params[:qty].to_i
    qty = 1 if qty <= 0

    item = current_cart.cart_items.find_by(product_id: product_id)
    if item
      item.update(qty: item.qty + qty)
    else
      current_cart.cart_items.create(product_id: product_id, qty: qty)
    end

    redirect_with_notice
  end

  def destroy
    item = current_cart.cart_items.find_by(id: params[:id])
    item&.destroy
    redirect_with_notice
  end

  private

  def redirect_path
    case params[:from]
    when "products"
      products_path
    when "cart", "cartitems_new"
      cart_path(current_cart)
    else
      products_path
    end
  end

  def notice_message
    case params[:from]
    when "products"
      nil
    else
      action_name == "create" ? "カートに追加しました" : "カートから削除しました"
    end
  end

  def redirect_with_notice
    if notice_message
      redirect_to redirect_path, notice: notice_message
    else
      redirect_to redirect_path
    end
  end
end