class CreateContactPages < ActiveRecord::Migration[7.2]
  def change
    create_table :contact_pages do |t|
      t.string :title
      t.text :content
      t.string :email
      t.string :phone
      t.string :business_hours
      t.text :address
      t.string :map_embed_url

      t.timestamps
    end
  end
end
