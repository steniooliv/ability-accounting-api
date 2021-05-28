class Company < ApplicationRecord
  belongs_to :accounting

  has_one :accountings
  has_many :invoices
end
