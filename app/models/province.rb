class Province < ApplicationRecord
  has_many :customers

  validates :name, presence: true, uniqueness: true
  validates :abbreviation, presence: true, uniqueness: true
end
