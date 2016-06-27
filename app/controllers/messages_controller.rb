class MessagesController < ApplicationController
  def create
    message = current_user.messages.new(message_params)
    if message.save
      # Here we are calling the #broadcast method on our Action Cable server, and passing it arguments:
      # 'messages', the name of the channel to which we are broadcasting.
      # Some content that will be sent through the channel as JSON:
      # message, set to the content of the message we just created.
      # user, set to the username of the user who created the message.
      ActionCable.server.broadcast 'messages',
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
