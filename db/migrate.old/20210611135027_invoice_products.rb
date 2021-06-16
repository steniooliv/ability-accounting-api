class InvoiceProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :invoice_products do |t|
      t.integer :product_id
      t.string :description, :limit => 100
      t.float :quantity
      t.float :price_unitary
      t.float :price_total
      t.float :discount_value
      t.float :expenses_value
      t.float :shipping_value
      t.float :safe_value
      t.string :icms_cst_csosn, :limit => 4
      t.float :icms_base
      t.float :icms_value
      t.float :sticms_base
      t.float :sticms_value
      t.string :ipi_cst, :limit => 2
      t.float :ipi_base
      t.float :ipi_value
      t.string :pis_cst, :limit => 2
      t.float :pis_base
      t.float :pis_value
      t.string :cofins_cst, :limit => 2
      t.float :cofins_base
      t.float :cofins_value
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
