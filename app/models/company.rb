class Company < ApplicationRecord
  belongs_to :accounting

  validates :name, :number, :last_fiscal_closing, presence: true

  has_many :accountings
  has_many :invoices, dependent: :destroy
end
