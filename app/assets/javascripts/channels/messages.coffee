App.messages = App.cable.subscriptions.create('MessagesChannel',
  received: (data) ->
    $('.messages[data-chat-room-id=' + data.chat_room_id.toString() + ']')
      .append @renderMessage(data)
  renderMessage: (data) ->
    '<div class=\'message\'>' +
    'At ' + data.timestamp + ' ' +
    data.user + ' Says: ' + data.message +
    '</div>'
)
