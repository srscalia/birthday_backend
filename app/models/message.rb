class Message < ApplicationRecord
  belongs_to :reminder

  validates :content, length: {minimum: 1, maximum: 120}
end
