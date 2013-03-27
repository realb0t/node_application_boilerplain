define (require) ->

  _       = require 'underscore'
  logger  = require('tracer').console()
  Synergy = require 'cs!Synergy'

  class ReceiverComponent extends noflo.Component

    constructor: (@socket) ->

      @outputs = out: new noflo.Port()

      @socket.on 'connection', (conn) =>
        conn.on 'data', (data) =>
          @outputs.out.send @produceCommand(data)

      @socket.on 'close', () =>
        @ouputs.out.disconnect()


    produceCommand: (data) ->
      command = data
      return command