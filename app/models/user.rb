class User < ApplicationRecord
  belongs_to :accounting

  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email

  has_one :accountings
end
