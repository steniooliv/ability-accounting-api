class User < ApplicationRecord
  belongs_to :accounting

  has_secure_password

  validates :name, :email, :password, :password_confirmation, presence: true

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :accountings
end
