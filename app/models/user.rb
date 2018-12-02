class User < ApplicationRecord
  has_many :reminders
  has_many :messages, through: :reminders
  has_secure_password
  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }
end
