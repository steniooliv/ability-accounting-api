class InvoiceProduct < ApplicationRecord
  belongs_to :invoice

  validates :product_id, :description, :quantity, :price_unitary, :price_total, :discount_value, :expenses_value, :shipping_value, :safe_value, :ncm, :cfop, :icms_cst_csosn, :cest, :icms_base, :icms_value, :sticms_base, :sticms_value, :ipi_cst, :ipi_base, :ipi_value, :pis_cst, :pis_base, :pis_value, :cofins_cst, :cofins_base, :cofins_value, :invoice_id, presence: true
  
  has_many :invoices
end