define (require) ->

  _       = require 'underscore'
  logger  = require('tracer').console()
  Synergy = require 'cs!Synergy'

  class AuthComponent extends noflo.Component

    constructor: ->

      @inputs = in: new noflo.Port()
      @outputs = out: new noflo.Port()

      @inPorts.in.on "data", (command) => 
        @outputs.out.send @onInputIn(command)

      @inPorts.in.on "disconnect", (command) =>
        @outputs.out.disconnect()

    onInputIn: (command) ->

      # ...

      return command