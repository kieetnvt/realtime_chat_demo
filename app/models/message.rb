class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  # after_commit { NotifyMessageJob.perform_now(self) }

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
