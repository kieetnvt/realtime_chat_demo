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
      type: 'user_message',
      timestamp: Time.now,
      user: "Admin",
      message: data['message'],
      chat_room_id: 1
  end

  def room_joined(data)
    if data['user'].present? && data['chat_room_id'].present?
      ActionCable.server.broadcast 'messages',
        type: 'notify_joined',
        timestamp: Time.now,
        user: data['user'],
        message: 'joined',
        chat_room_id: data['chat_room_id']
    end
  end
end
