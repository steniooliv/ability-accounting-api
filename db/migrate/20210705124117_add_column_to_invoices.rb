class AddColumnToInvoices < ActiveRecord::Migration[6.1]
  def change
    add_column :invoices, :status, :string
  end
end
