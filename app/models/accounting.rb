class Accounting < ApplicationRecord

  validates :name, presence: true

  has_many :users
  has_many :companies
end
