class Accounting < ApplicationRecord

  has_many :users
  has_many :companies
end
