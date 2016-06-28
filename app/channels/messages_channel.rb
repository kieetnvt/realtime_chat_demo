class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'messages'
  end

  def unsubscribed
  end

  # custom method
  # broadcast message to room 1
  def speak(data)
    ActionCable.server.broadcast 'messages',
      timestamp: Time.now,
      user: "Admin",
      message: data['message'],
      chat_room_id: 1
  end
end
