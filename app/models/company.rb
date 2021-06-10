class Company < ApplicationRecord
  belongs_to :accounting

  validates :name, presence: true

  has_many :accountings
  has_many :invoices
end
