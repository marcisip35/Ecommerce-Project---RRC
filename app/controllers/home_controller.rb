class HomeController < ApplicationController
  def index
    @categories = Category.order(:name)
    @selected_category = Category.find_by(id: params[:category_id])
    @search_words = params[:search_keywords]

    products = Product.keyword_search(@search_words)

    if @selected_category
      products = products.joins(:categories)
      products = products.where(categories: { id: @selected_category.id })
    end

    if params[:filter] == "sale"
      products = products.where(on_sale: true)
    elsif params[:filter] == "new"
      three_days_ago = 3.days.ago
      products = products.where("products.created_at >= ?", three_days_ago)
    end

    products = products.distinct
    products = products.order("products.id")

    @product_count = products.count
    @products = products.page(params[:page]).per(9)
  end
end