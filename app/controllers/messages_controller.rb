class MessagesController < ApplicationController
  def create
    message = current_user.messages.new(message_params)
    if message.save
      ActionCable.server.broadcast 'messages',
        type: 'user_message',
        timestamp: message.timestamp,
        user: message.user.name,
        message: message.body,
        chat_room_id: message.chat_room.id
      head :ok
    else
      redirect_to chat_rooms_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :chat_room_id)
  end
end
