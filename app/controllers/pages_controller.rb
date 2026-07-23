class PagesController < ApplicationController
  def about
    @about_page = AboutPage.first
  end

  def contact
    @contact_page = ContactPage.first
  end

  def shell_jackets
    @category = Category.find_by!(name: "Shell Jackets")
    @products = @category.products.order(:id)
  end

  def insulated_jackets
    @category = Category.find_by!(name: "Insulated Jackets")
    @products = @category.products.order(:id)
  end

  def lifestyle
    @category = Category.find_by!(name: "Lifestyle")
    @products = @category.products.order(:id)
  end
end
