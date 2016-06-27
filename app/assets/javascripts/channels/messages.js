// We add our new subscription to our consumer with App.cable.subscriptions.create. We give this function an argument of the name of the channel to which we want to subscribe, MessagesChannel.
// When this subscriptions.create function is invoked, it will invoke the MessagesChannel#subscribed method, which is in fact a callback method.
// MessagesChannel#subscribed streams from our messages broadcast, sending along any new messages as JSON to the client-side subscription function.
// Then, the received function is invoked, with an argument of this new message JSON. The received function in turn calls a helper function that we have defined, renderMessage, which simply appends new messages to the DOM, using the $("#messages") jQuery selector, which can be found on the chatroom show page.
//
App.messages = App.cable.subscriptions.create('MessagesChannel', {
  received: function(data){
    return $(".messages[data-chat-room-id="+data.chat_room_id.toString()+"]").append(this.renderMessage(data));
  },

  renderMessage: function(data){
    return "<div class='message'>" +
      "At " +
      data.timestamp +
      " " +
      data.user +
      " Says: " +
      data.message +
      "</div>"
  }
})
