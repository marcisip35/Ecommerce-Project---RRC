class CheckoutsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @cart_items = []
    @subtotal = 0
    cart = session[:cart] || {}

    cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)

      next unless product.present? && product.stock_quantity > 0

      quantity = quantity.to_i

      quantity = 1 if quantity < 1

      if quantity > product.stock_quantity
        quantity = product.stock_quantity
        cart[product_id] = quantity
      end

      unit_price = product.price

      unit_price = product.sale_price if product.on_sale && product.sale_price.present?

      line_total = unit_price * quantity
      @subtotal += line_total

      @cart_items << {
        product:    product,
        quantity:   quantity,
        unit_price: unit_price,
        line_total: line_total
      }
    end

    session[:cart] = cart

    if @cart_items.empty?
      redirect_to cart_path,
                  alert: "Your cart is empty."
      return
    end

    @provinces = Province.order(:name)

    @selected_province = if params[:province_id].present?
                           Province.find_by(
                             id: params[:province_id]
                           )
                         else
                           current_customer.province
                         end

    @first_name = params[:first_name].presence ||
                  current_customer.first_name

    @last_name = params[:last_name].presence ||
                 current_customer.last_name

    @street_address = if params.key?(:street_address)
                        params[:street_address]
                      else
                        current_customer.street_address
                      end

    @city = if params.key?(:city)
              params[:city]
            else
              current_customer.city
            end

    @postal_code = if params.key?(:postal_code)
                     params[:postal_code]
                   else
                     current_customer.postal_code
                   end

    @gst_amount = 0
    @pst_amount = 0
    @hst_amount = 0

    if @selected_province.present?
      @gst_amount = (
        @subtotal * @selected_province.gst_rate / 100
      ).round(2)

      @pst_amount = (
        @subtotal * @selected_province.pst_rate / 100
      ).round(2)

      @hst_amount = (
        @subtotal * @selected_province.hst_rate / 100
      ).round(2)
    end

    @grand_total = (
      @subtotal +
      @gst_amount +
      @pst_amount +
      @hst_amount
    ).round(2)
  end

  def create
    cart = session[:cart] || {}

    if cart.empty?
      redirect_to cart_path,
                  alert: "Your cart is empty."
      return
    end

    first_name = params[:first_name].to_s.strip
    last_name = params[:last_name].to_s.strip
    street_address = params[:street_address].to_s.strip
    city = params[:city].to_s.strip
    postal_code = params[:postal_code].to_s.strip
    province = Province.find_by(id: params[:province_id])

    if first_name.blank? ||
       last_name.blank? ||
       province.nil?
      redirect_to checkout_path(
        first_name:     first_name,
        last_name:      last_name,
        street_address: street_address,
        city:           city,
        postal_code:    postal_code,
        province_id:    params[:province_id]
      ),
                  alert: "Enter your name and select a province or territory."
      return
    end

    cart_items = []
    subtotal = 0

    cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      quantity = quantity.to_i

      if product.nil?
        redirect_to cart_path,
                    alert: "A product in your cart is no longer available."
        return
      end

      if quantity < 1 || quantity > product.stock_quantity
        redirect_to cart_path,
                    alert: "Review the available product quantities."
        return
      end

      unit_price = product.price

      unit_price = product.sale_price if product.on_sale && product.sale_price.present?

      line_total = unit_price * quantity
      subtotal += line_total

      cart_items << {
        product:    product,
        quantity:   quantity,
        unit_price: unit_price,
        line_total: line_total
      }
    end

    gst_amount = (
      subtotal * province.gst_rate / 100
    ).round(2)

    pst_amount = (
      subtotal * province.pst_rate / 100
    ).round(2)

    hst_amount = (
      subtotal * province.hst_rate / 100
    ).round(2)

    grand_total = (
      subtotal +
      gst_amount +
      pst_amount +
      hst_amount
    ).round(2)

    order = nil

    ActiveRecord::Base.transaction do
      current_customer.update!(
        first_name:     first_name,
        last_name:      last_name,
        street_address: street_address,
        city:           city,
        postal_code:    postal_code,
        province:       province
      )

      order = current_customer.orders.create!(
        province:       province,
        status:         "unpaid",
        first_name:     first_name,
        last_name:      last_name,
        street_address: street_address,
        city:           city,
        postal_code:    postal_code,
        subtotal:       subtotal,
        gst_rate:       province.gst_rate,
        pst_rate:       province.pst_rate,
        hst_rate:       province.hst_rate,
        gst_amount:     gst_amount,
        pst_amount:     pst_amount,
        hst_amount:     hst_amount,
        grand_total:    grand_total
      )

      cart_items.each do |cart_item|
        order.order_items.create!(
          product:    cart_item[:product],
          quantity:   cart_item[:quantity],
          unit_price: cart_item[:unit_price],
          line_total: cart_item[:line_total]
        )

        product = cart_item[:product]
        new_stock = product.stock_quantity -
                    cart_item[:quantity]

        product.update!(
          stock_quantity: new_stock
        )
      end
    end

    session[:cart] = {}

    redirect_to order_confirmation_path(order)
  rescue ActiveRecord::RecordInvalid => e
    message = e.record.errors.full_messages.first

    redirect_to checkout_path(
      first_name:     first_name,
      last_name:      last_name,
      street_address: street_address,
      city:           city,
      postal_code:    postal_code,
      province_id:    params[:province_id]
    ),
                alert: message
  end
end
