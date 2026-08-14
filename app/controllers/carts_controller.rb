class CartsController < ApplicationController
  def show
    @cart_items = []
    @subtotal = 0

    return unless session[:cart].present?

    session[:cart].each do |product_id, quantity|
      product = Product.find_by(id: product_id)

      next unless product.present?

      unit_price = product.price

      unit_price = product.sale_price if product.on_sale && product.sale_price.present?

      line_total = unit_price * quantity.to_i
      @subtotal += line_total

      @cart_items << {
        product:    product,
        quantity:   quantity.to_i,
        unit_price: unit_price,
        line_total: line_total
      }
    end
  end

  def add
    product = Product.find(params[:product_id])
    cart = session[:cart] || {}
    product_id = product.id.to_s

    if cart[product_id].present?
      current_quantity = cart[product_id].to_i

      cart[product_id] = current_quantity + 1 if current_quantity < product.stock_quantity
    else
      cart[product_id] = 1
    end

    session[:cart] = cart

    redirect_to cart_path,
                notice: "#{product.name} was added to your cart."
  end

  def update
    product = Product.find(params[:product_id])
    cart = session[:cart] || {}
    product_id = product.id.to_s
    quantity = params[:quantity].to_i

    quantity = 1 if quantity < 1

    quantity = product.stock_quantity if quantity > product.stock_quantity

    cart[product_id] = quantity
    session[:cart] = cart

    redirect_to cart_path,
                notice: "#{product.name} quantity was updated."
  end

  def remove
    product = Product.find(params[:product_id])
    cart = session[:cart] || {}
    product_id = product.id.to_s

    cart.delete(product_id)
    session[:cart] = cart

    redirect_to cart_path,
                notice: "#{product.name} was removed from your cart."
  end
end
