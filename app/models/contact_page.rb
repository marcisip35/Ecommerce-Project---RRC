class ContactPage < ApplicationRecord
  validates :title, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [
      "address",
      "business_hours",
      "content",
      "created_at",
      "email",
      "id",
      "map_embed_url",
      "phone",
      "title",
      "updated_at"
    ]
  end
end
