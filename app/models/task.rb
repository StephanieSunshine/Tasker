class Task < ApplicationRecord
  belongs_to :user
  has_many :messages
  enum state: [ :queued, :active, :completed ]
end
