class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :customer

  has_one :companies
  has_one :customers
end
