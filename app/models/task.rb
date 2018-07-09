class Task < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  enum state: [ :queued, :active, :completed ]

  after_create :populate_messages

  def populate_messages
    self.messages.create({user: 0, data: 'Welcome to the realtime chat dialog.  To send a message, type the message into the box below and click send.'})
  end
end
