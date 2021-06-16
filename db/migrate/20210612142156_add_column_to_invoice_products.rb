class AddColumnToInvoiceProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :invoice_products, :ncm, :string
    add_column :invoice_products, :cfop, :string
    add_column :invoice_products, :cest, :string
  end
end
