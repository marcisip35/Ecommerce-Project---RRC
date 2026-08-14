class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :province

  has_many :order_items, dependent: :destroy

  validates :status,
            presence:  true,
            inclusion: { in: ["unpaid", "paid", "shipped"] }

  validates :first_name,
            :last_name,
            presence: true

  validates :subtotal,
            :gst_rate,
            :pst_rate,
            :hst_rate,
            :gst_amount,
            :pst_amount,
            :hst_amount,
            :grand_total,
            numericality: { greater_than_or_equal_to: 0 }
end
