class User < ApplicationRecord
  has_many :reminders
  has_many :messages, through: :reminders
end
