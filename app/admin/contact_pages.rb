ActiveAdmin.register ContactPage do
  actions :index, :show, :edit, :update

  permit_params :title, :content, :email, :phone,
                :business_hours, :address, :map_embed_url

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
      f.input :email
      f.input :phone
      f.input :business_hours
      f.input :address
      f.input :map_embed_url, as: :text
    end

    f.actions
  end
end
