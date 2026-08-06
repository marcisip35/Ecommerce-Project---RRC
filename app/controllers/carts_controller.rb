class CartsController < ApplicationController
  def show
    @cart_items = []

    if session[:cart].present?
      session[:cart].each do |product_id, quantity|
        product = Product.find_by(id: product_id)

        if product.present?
          @cart_items << {
            product: product,
            quantity: quantity.to_i
          }
        end
      end
    end
  end

  def add
    product = Product.find(params[:product_id])
    cart = session[:cart] || {}
    product_id = product.id.to_s

    if cart[product_id].present?
      cart[product_id] = cart[product_id].to_i + 1
    else
      cart[product_id] = 1
    end

    session[:cart] = cart

    redirect_to cart_path,
                notice: "#{product.name} was added to your cart."
  end
end
