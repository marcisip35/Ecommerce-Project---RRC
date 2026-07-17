ActiveAdmin.register Product do
  config.filters = false

  permit_params :name, :description, :price, :stock_quantity,
                :on_sale, :sale_price, :image, category_ids: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :on_sale
      f.input :sale_price
      f.input :categories, as: :check_boxes
      f.input :image, as: :file
    end

    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :on_sale
      row :sale_price

      row :categories do |product|
        product.categories.map(&:name).join(", ")
      end

      row :image do |product|
        if product.image.attached?
          image_tag product.image, style: "max-width: 300px;"
        else
          "No image uploaded"
        end
      end

      row :created_at
      row :updated_at
    end

    active_admin_comments
  end
end