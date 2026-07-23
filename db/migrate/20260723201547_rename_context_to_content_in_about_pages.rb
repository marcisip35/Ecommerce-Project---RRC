class RenameContextToContentInAboutPages < ActiveRecord::Migration[7.2]
  def change
    rename_column :about_pages, :context, :content
  end
end
