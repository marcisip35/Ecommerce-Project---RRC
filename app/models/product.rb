class Product < ApplicationRecord
  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }

  validates :stock_quantity, presence: true,
                             numericality: {
                               only_integer: true,
                               greater_than_or_equal_to: 0
                             }

  validates :sale_price,
            numericality: { greater_than_or_equal_to: 0 },
            allow_blank: true

  def self.ransackable_attributes(auth_object = nil)
    [
      "created_at",
      "description",
      "id",
      "name",
      "on_sale",
      "price",
      "sale_price",
      "stock_quantity",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    [
      "categories",
      "category_products"
    ]
  end

  def self.keyword_search(keywords)
    if keywords.nil?
      return Product.all
    end

    keywords = keywords.strip

    if keywords == ""
      return Product.all
    end

    search_words = "%" + keywords + "%"

    Product.where(
      "products.name LIKE ? OR products.description LIKE ?",
      search_words,
      search_words
    )
  end
end