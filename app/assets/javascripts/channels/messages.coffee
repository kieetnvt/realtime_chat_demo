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
      '<span class=\'chat-img pull-left\'>' +
        '<img src=\'http://placehold.it/50/55C1E7/fff\' alt=\'User Avatar\' class=\'img-circle\'>' +
      '</span>' +
      '<div class=\'chat-body clearfix\'>' +
        '<div class=\'header\'>' +
          '<strong class=\'primary-font\'>' +
            data.user +
          '</strong>' +
          '<small class=\'pull-right text-muted\'>' +
              '<i class=\'fa fa-clock-o fa-fw\'></i>' +
              data.timestamp +
          '</small>' +
        '</div>' +
        '<p>' +
          data.message +
        '</p>' +
      '</div>' +
    '</li>'
)
