class NotifyMessageJob < ApplicationJob
  def perform(message)
    ActionCable.server.broadcast 'messages',
      timestamp: Time.now,
      user: "NEW MESSAGE",
      message: message.body,
      chat_room_id: 1
  end
end
