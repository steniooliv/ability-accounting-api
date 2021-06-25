class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :customer

  validates :customer_id, :company_id, :number, :serie, :model, :type_record, :type_movement, :date_issue, :date_departure, :access_key, :total_product, :discount_value, :expenses_value, :shipping_value, :safe_value, :icms_base, :icms_value, :sticms_base, :sticms_value, :ipi_base, :ipi_value, :pis_base, :pis_value, :cofins_base, :cofins_value, :invoice_value, presence: true

  alias_attribute :name, :number

  has_many :companies
  has_many :customers
  has_many :invoice_products, dependent: :destroy

end
