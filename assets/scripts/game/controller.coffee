define [
  'jquery'
  'underscore'
  'backbone'
  'Channel'
  'easel'
], ($, _, Backbone, Channel) ->

  class ControllerBase

    constructor: (@model, @view, @tickCallback) ->
      @view.controller = @

    setupControls: () ->

    setupTicker: () ->
      createjs.Ticker.setFPS(@model.get('refreshRate'))
      createjs.Ticker.useRAF = true
      createjs.Ticker.addListener(@)

    childTick: () ->

    tick: () ->
      @view.stage.update()
      @tickCallback() if @tickCallback
      @childTick()

  return ControllerBase
