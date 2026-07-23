class AboutPage < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [
      "content",
      "created_at",
      "id",
      "title",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
