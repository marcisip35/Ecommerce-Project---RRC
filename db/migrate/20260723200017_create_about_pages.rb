class CreateAboutPages < ActiveRecord::Migration[7.2]
  def change
    create_table :about_pages do |t|
      t.string :title
      t.string :context
      t.string :text

      t.timestamps
    end
  end
end
