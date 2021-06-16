class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.integer :number
      t.string :serie
      t.string :model
      t.string :type_record
      t.string :type_movement
      t.datetime :date_issue
      t.datetime :date_departure
      t.string :access_key
      t.float :total_product
      t.float :discount_value
      t.float :expenses_value
      t.float :shipping_value
      t.float :safe_value
      t.float :icms_base
      t.float :icms_value
      t.float :sticms_base
      t.float :sticms_value
      t.float :ipi_base
      t.float :ipi_value
      t.float :pis_base
      t.float :pis_value
      t.float :cofins_base
      t.float :cofins_value
      t.float :invoice_value
      t.references :customer, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
