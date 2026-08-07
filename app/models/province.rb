class Province < ApplicationRecord
  has_many :customers
  has_many :orders

  validates :name, presence: true, uniqueness: true
  validates :abbreviation, presence: true, uniqueness: true

  validates :gst_rate,
            :pst_rate,
            :hst_rate,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 100
            }

  def self.ransackable_attributes(_auth_object = nil)
    [
      "abbreviation",
      "gst_rate",
      "hst_rate",
      "id",
      "name",
      "pst_rate"
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
