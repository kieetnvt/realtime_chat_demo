getMessages = () ->
  div = $('.panel-body')
  div.scrollTop div.prop('scrollHeight')
  return

$ ->
  getMessages()

  $('#chat-enter').keypress (e) ->
    if e.which == 13
      e.preventDefault()
      $('#new_message').submit()
      $(this).val('')

  setInterval (->
    getMessages()
    return
  ), 100
