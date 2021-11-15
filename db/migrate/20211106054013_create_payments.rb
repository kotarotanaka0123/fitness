class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :email
      t.text :description
      t.string :currency
      t.string :customer_id
      t.date :payment_date
      t.string :payment_status
      t.string :uuid
      t.string :charge_id
      t.float :stripe_commission
      t.float :amount_after_subtract_commission
      t.string :receipt_url
      t.string :product_id
      t.string :product_name

      t.references :user
      t.timestamps
    end
  end
end
