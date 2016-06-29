App.messages = App.cable.subscriptions.create('MessagesChannel',
  connected: ->
    console.log("connected")
    user = $('#current_user_name').val()
    chat_room_id = $('#current_chat_room_id').val()
    @perform 'room_joined', { user: user, chat_room_id: chat_room_id }

  disconnected: ->
    console.log("disconnected")
    console.log($("#current_user_name").val())
    console.log($("#current_chat_room_id").val())

  received: (data) ->
    if data.type == 'notify_joined'
      $('.messages[data-chat-room-id=' + data.chat_room_id.toString() + ']')
        .append '<p>' + data.user + ' joined this room' + '</p>'
    if data.type == 'user_message'
      $('.messages[data-chat-room-id=' + data.chat_room_id.toString() + ']')
        .append @messageTemplate(data)

  speak: (message)->
    @perform 'speak', message: message

  messageTemplate: (data) ->
    '<li class=\'left clearfix\'>' +
      '<div class=\'header\'>' +
        '<span class=\'primary-font\'>' +
          data.user +
        '</span>' +
        '<small class=\'pull-right text-muted\'>' +
            '<i class=\'fa fa-clock-o fa-fw\'></i>' +
            data.timestamp +
        '</small>' +
        '<div class=\'lead\'>' +
          data.message +
        '</div>' +
      '</div>' +
    '</li>'
)
