define [
  'jquery'
  'underscore'
  'backbone'
  'FrontendViewsBaseHtmlPage'
  'Channel'
  'text!static_tmp/pages/chat.html'
], ($, _, Backbone, BaseHtmlPage, Channel, pageTemplate) ->

  class ChatPage extends BaseHtmlPage
    id: 'chat_page'

    events:
      'peer:connection': 'peerConnection'
      'peer:receive': 'peerReceive'
      'peer:open': 'peerOpen'
      'peer:close': 'peerClose'
      'peer:error': 'peerError'
      'click #send': 'onSend'
      'click #connect': 'onConnect'

    peerBind: () ->
      @peer = Channel.peer()()
      @peer.on 'receive', (data, pid) => @$el.trigger('peer:receive', message: data, pid: pid)
      @peer.on 'open', (pid) => @$el.trigger('peer:open', pid)
      @peer.on 'connection', (pid) => @$el.trigger('peer:connection', pid)
      @peer.on 'close', (err) => @$el.trigger('peer:close', err)
      @peer.on 'error', (err) => @$el.trigger('peer:error', err)

    initChat: () ->
      if @peer.isConnected()
        console.log('now conected', @peer.currentPid(), @peer.currentConnection().peer)
        @peerOpen(null, @peer.currentPid())
        @peerConnection(null, @peer.currentConnection().peer)
      else
        console.log('not conected')

    peerConnection: (event, pid) ->
      $('.connection').val('').hide()
      $('#status').text('Connected on ' + pid)

    peerReceive: (event, data) ->
      @addMessage(data.pid, data.message)

    peerOpen: (event, pid) ->
      $('#status').text('ready')
      $('#pid').text(pid)

    peerClose: (event, err) ->
      $('.connection').show()
      alert('close ' + err)

    peerError: (event, err) ->
      alert('error ' + err)

    onSend: (event) ->
      msg = $('#message').val()
      @peer.send(msg)
      @addMessage('self', msg)

    onConnect: (event) ->
      pid = $('#other_pid').val()
      @peer.connectPid pid

    addMessage: (nick, message) ->
      box = @$el.find('.chat .empty.message_box').clone()
      @$el.add('.chat').append(box)
      $box = $(box)
      $box.show()
      $box.removeClass('empty')
      $box.find('.from').text(nick)
      $box.find('.message').text(message)

    render: ->
      $(@el).html(pageTemplate)
      
      @peerBind()
      @deferredRender () => 
        @initChat()
        Synergy.current.screenInit(null, 1000)

      return @

  return ChatPage