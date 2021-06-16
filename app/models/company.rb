class Company < ApplicationRecord
  belongs_to :accounting

  validates :name, :number, presence: true

  has_many :accountings
  has_many :invoices
end
