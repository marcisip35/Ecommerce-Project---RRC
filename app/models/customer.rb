class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [ :username ]

  belongs_to :province, optional: true

  validates :username, presence: true, uniqueness: true
end
