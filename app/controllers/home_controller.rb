class HomeController < ApplicationController
  def index
    @categories = Category.order(:name)
    @selected_category = Category.find_by(id: params[:category_id])

    if @selected_category
      @products = @selected_category.products.order(:id).limit(21)
    else
      @products = Product.order(:id).limit(21)
    end
  end
end