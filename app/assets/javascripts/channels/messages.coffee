App.messages = App.cable.subscriptions.create('MessagesChannel',
  connected: ->
    console.log("connected")

  disconnected: ->
    console.log("disconnected")

  received: (data) ->
    $('.messages[data-chat-room-id=' + data.chat_room_id.toString() + ']')
      .append @messageTemplate(data)

  renderMessage: (data) ->
    '<div class=\'message\'>' +
    'At ' + data.timestamp + ' ' +
    data.user + ' Says: ' + data.message +
    '</div>'

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
