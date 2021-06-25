class Customer < ApplicationRecord

  validates :name, presence: true

  has_many :invoices, dependent: :destroy
end
