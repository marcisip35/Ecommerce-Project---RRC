ActiveAdmin.register Province do
  actions :index, :show, :edit, :update

  permit_params :gst_rate,
                :pst_rate,
                :hst_rate

  config.sort_order = "name_asc"

  index do
    id_column

    column :name
    column :abbreviation

    column "GST Rate" do |province|
      "#{province.gst_rate}%"
    end

    column "Provincial Tax Rate" do |province|
      if province.abbreviation == "QC"
        "QST #{province.pst_rate}%"
      elsif province.abbreviation == "MB"
        "RST #{province.pst_rate}%"
      else
        "PST #{province.pst_rate}%"
      end
    end

    column "HST Rate" do |province|
      "#{province.hst_rate}%"
    end

    actions
  end

  filter :name
  filter :abbreviation

  show do
    attributes_table do
      row :name
      row :abbreviation

      row "GST Rate" do |province|
        "#{province.gst_rate}%"
      end

      row "Provincial Tax Rate" do |province|
        if province.abbreviation == "QC"
          "QST #{province.pst_rate}%"
        elsif province.abbreviation == "MB"
          "RST #{province.pst_rate}%"
        else
          "PST #{province.pst_rate}%"
        end
      end

      row "HST Rate" do |province|
        "#{province.hst_rate}%"
      end

      row :created_at
      row :updated_at
    end
  end

  form do |form|
    provincial_tax_label = "PST Rate (%)"

    if form.object.abbreviation == "QC"
      provincial_tax_label = "QST Rate (%)"
    elsif form.object.abbreviation == "MB"
      provincial_tax_label = "RST Rate (%)"
    end

    form.inputs "Province Tax Rates" do
      form.input :name,
                 input_html: { disabled: true }

      form.input :abbreviation,
                 input_html: { disabled: true }

      form.input :gst_rate,
                 label: "GST Rate (%)",
                 input_html: {
                   min: 0,
                   max: 100,
                   step: 0.001
                 }

      form.input :pst_rate,
                 label: provincial_tax_label,
                 input_html: {
                   min: 0,
                   max: 100,
                   step: 0.001
                 }

      form.input :hst_rate,
                 label: "HST Rate (%)",
                 input_html: {
                   min: 0,
                   max: 100,
                   step: 0.001
                 }
    end

    form.actions
  end
end
