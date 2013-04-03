define [
  'jquery'
  'underscore'
  'backbone'
  'easel'
], ($, _, Backbone) ->

  class ViewBase extends Backbone.View
    
    el: $('#game')
    stage: null
    player: null
    baddie: null
    imagesLoaded: 0

    initialize: (params = {}) ->
      @controller = params['controller']
      @on 'imagesLoaded', () =>
        @controller.setupControls()
        @controller.setupTicker()
      @render()

    createImage: (url, callback, x, y, regX, regY) ->
      img     = new Image()
      img.src = url
      self    = @
      $(img).load () -> callback(self, img, x, y, regX, regY)

    createBitmap: (img, x, y, regX, regY) ->
      bmp = new createjs.Bitmap(img)
      bmp.x = x
      bmp.y = y
      bmp.regX = regX
      bmp.regY = regY
      @stage.addChild(bmp)
      @stage.update()
      bmp

    render: () ->

  return ViewBase
  return ViewBase