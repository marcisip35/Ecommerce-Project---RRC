ActiveAdmin.register AboutPage do
  config.filters = false
  config.batch_actions = false

  actions :index, :show, :edit, :update

  permit_params :title, :content, :image

  index do
    id_column
    column :title
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
      f.input :image, as: :file
    end

    f.actions
  end

  show do
    attributes_table do
      row :title
      row :content

      row :image do |page|
        if page.image.attached?
          image_tag page.image, style: "max-width: 400px;"
        else
          "No image uploaded"
        end
      end
    end
  end
end
