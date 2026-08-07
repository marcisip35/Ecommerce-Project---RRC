class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer,
                   null: false,
                   foreign_key: true

      t.references :province,
                   null: false,
                   foreign_key: true

      t.string :status,
               null: false,
               default: "unpaid"

      t.string :first_name,
               null: false

      t.string :last_name,
               null: false

      t.string :street_address,
               null: false

      t.string :city,
               null: false

      t.string :postal_code,
               null: false

      t.decimal :subtotal,
                precision: 10,
                scale: 2,
                null: false,
                default: 0

      t.decimal :gst_rate,
                precision: 5,
                scale: 3,
                null: false,
                default: 0

      t.decimal :pst_rate,
                precision: 5,
                scale: 3,
                null: false,
                default: 0

      t.decimal :hst_rate,
                precision: 5,
                scale: 3,
                null: false,
                default: 0

      t.decimal :gst_amount,
                precision: 10,
                scale: 2,
                null: false,
                default: 0

      t.decimal :pst_amount,
                precision: 10,
                scale: 2,
                null: false,
                default: 0

      t.decimal :hst_amount,
                precision: 10,
                scale: 2,
                null: false,
                default: 0

      t.decimal :grand_total,
                precision: 10,
                scale: 2,
                null: false,
                default: 0

      t.string :stripe_customer_id
      t.string :stripe_payment_id

      t.timestamps
    end
  end
end
