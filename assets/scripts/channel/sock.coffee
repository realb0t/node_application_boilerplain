define [
  'jquery'
  'underscore'
  'backbone'
  'sock'
], ($, _, Backbone) ->

  ### SockChannel - Event-proxy для SockJS

  Канал для обмена сообщениями между 
  двумя пользователя по socket message (WebSocket)

  API

  socket = new SockChannel({ path: null, port: 9000, host: 'localhost' })

  socket.on 'open', (e) ->
  socket.on 'receive', (e) ->
  socket.on 'close', (e) ->

  ###

  class SockChannel

    # Конструктор
    #
    # params = {
    #   host:
    #   port:
    #   path:
    # }
    constructor: (params = {}) ->
      _(@).extend(Backbone.Events)

      @sock = new SockJS('http://localhost:9999/echo');

      afterOpen    = (e) => @trigger('open', e)
      afterReceive = (e) => @trigger('receive', e)
      afterClose   = (e) => @trigger('close', e)

      @sock.onopen    = (e) -> afterOpen(e)
      @sock.onmessage = (e) -> afterReceive(e) # e.data
      @sock.onclose   = (e) -> afterClose(e)

    send: (data) -> @sock.send(data)

  return SockChannel