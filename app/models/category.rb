class Category < ApplicationRecord
  has_many :category_products, dependent: :destroy
  has_many :products, through: :category_products

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "name",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    [
      "category_products",
      "products"
    ]
  end
end