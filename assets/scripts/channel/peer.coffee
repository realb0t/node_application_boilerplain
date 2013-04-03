define [
  'jquery'
  'underscore'
  'backbone'
  'peer'
], ($, _, Backbone) ->

  ### PeerChannel - Event-proxy для PeerJS

  Канал для обмена сообщениями между 
  двумя пользователя по P2P (WebRTC)
  
  API

  peer = new PeerChannel({ alias: null, port: 9000, host: 'localhost' })
  
  Повесить обработчики событий
  peer.on 'receive', (data) -> получение сообщения
  peer.on 'open', (pid) -> подключение к Peer-серверу
  peer.on 'close', (err) -> закрытие коннекта пользователе м
  peer.on 'error', (err) -> ошибка подключения

  # Подключение к другому пользователю
  peer.connectAlias(alias) по индетификатору
  или
  peer.connectPid(pid) или по PID

  # Отправка сообщения
  peer.send(msg)
  
  ###

  conn = null

  class PeerChannel

    # Конструктор
    #
    # params = {
    #   port: <порт Peer-сервера>
    #   host: <хост Peer-сервера>
    #   alias: <Индетификатор пользователя для связи с PID>
    # }
    constructor: (params = {}) ->
      _(@).extend(Backbone.Events)
      @alias = params['alias']
      @port  = params['port'] || 9000
      @host  = params['host'] || 'localhost'
      @debug = params['debug'] || false
      @conn  = null

      @peer = new Peer({ port: @port, host: @host, debug: @debug })

      sendCallback           = (data, pid) => @trigger 'receive', data, pid
      afterConnectedCallback = (pid)  => @trigger 'connection', pid
      afterCloseCallback     = (err)  => @trigger 'close', err
      afterOpenCalbback      = (pid)  => 
        @pid = pid
        @trigger 'open', pid


      # Открытие коннекта к Peer-серверу
      @peer.on 'open', (pid) -> afterOpenCalbback(pid)

      @connectCallback = (c) ->
        conn = c
        conn.on 'data', (data) -> sendCallback(data, c.peer)
        conn.on 'close', (err) -> afterCloseCallback(err) # Событие може долго залипать в PeerJS
        afterConnectedCallback(c.peer)
      
      # Подключение другого пользователя
      @peer.on 'connection', @connectCallback

    isConnected: () ->
      conn != null

    currentConnection: () ->
      conn

    currentPid: () ->
      @pid

    # Подключние по PID
    connectPid: (pid) ->
      throw 'Not registered as peer' unless @peer
      #throw 'Already connected' unless conn

      connectErrorCalback = (err) => @trigger 'error', err
      
      conn = @peer.connect(pid)
      @connectCallback conn
      conn.on 'error', (err) => connectErrorCalback(err)
      pid

    # Отправить сообщение
    send: (data) ->
      throw 'Not created connection' unless conn
      conn.send(data)

    # TODO: реализовать

    # Регистрация индетификатора с PID после подключения
    registerAlias: (alias, pid) ->

    # Получение PID по индетификатору
    pidByAlias: (alias, callback) ->

    # Получение индетификатора по PID
    aliasByPid: (pid, callback) ->

    # Подключение по индетивикатору
    connectAlias: (alias) ->

  return PeerChannel