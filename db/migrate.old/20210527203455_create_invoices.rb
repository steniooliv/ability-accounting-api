class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.integer :number
      t.string :serie, :limit => 3
      t.string :model, :limit => 2
      t.string :type_record, :limit => 4
      t.string :type_movement, :limit => 1
      t.date :date_issue
      t.date :date_departure
      t.string :access_key, :limit => 44
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
      t.references :company, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
