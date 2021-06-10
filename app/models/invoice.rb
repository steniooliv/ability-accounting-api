class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :customer

  validates :number, :serie, :total_value, presence: true

  has_many :companies
  has_many :customers

  has_one_attached :invoice_xml
end
