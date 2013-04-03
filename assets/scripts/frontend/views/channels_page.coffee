define [
  'jquery'
  'underscore'
  'backbone'
  'FrontendViewsBaseHtmlPage'
  'Channel'
  'text!static_tmp/pages/channels.html'
], ($, _, Backbone, BaseHtmlPage, Channel, pageTemplate) ->

  class ChannelsPage extends BaseHtmlPage
    id: 'channels_page'

    events:
      'click #ping': 'onPing'
      'socket:open': 'socketOpen'
      'socket:close': 'socketClose'
      'socket:receive': 'socketReceive'

    socketBind: () ->
      @socket = Channel.sock()()
      @socket.on 'open', (e) => @$el.trigger 'socket:open', e
      @socket.on 'close', (e) => @$el.trigger 'socket:close', e
      @socket.on 'receive', (e) => @$el.trigger 'socket:receive', e.data

    socketOpen: () ->
      console.log('open')
      @$el.find('.socket .status').html('Socket connected')

    socketReceive: (event, data) ->
      console.log('receive', data)
      @onPong() if data == 'pong'

    socketClose: () ->
      console.log('close')
      @$el.find('.socket .status').html('Socket closed')

    now: () -> +new Date()

    onPing: () ->
      @$el.find('.socket .channel').append('Ping(' + @now() + ') -></br>')
      @socket.send('ping')

    onPong: () ->
      @$el.find('.socket .channel').append('<- Pong(' + @now() + ')</br><hr>')

    render: ->
      @socketBind()
      $(@el).html(pageTemplate)      
      @deferredRender () -> Synergy.current.screenInit(null, 1000)

      return @

  return ChannelsPage