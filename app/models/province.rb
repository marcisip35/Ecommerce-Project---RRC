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
end
