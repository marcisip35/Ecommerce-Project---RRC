class AddTaxRatesToProvinces < ActiveRecord::Migration[7.2]
  def change
    add_column :provinces,
               :gst_rate,
               :decimal,
               precision: 5,
               scale: 3,
               default: 0,
               null: false

    add_column :provinces,
               :pst_rate,
               :decimal,
               precision: 5,
               scale: 3,
               default: 0,
               null: false

    add_column :provinces,
               :hst_rate,
               :decimal,
               precision: 5,
               scale: 3,
               default: 0,
               null: false
  end
end
