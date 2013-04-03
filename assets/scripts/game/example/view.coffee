define [
  'jquery'
  'underscore'
  'backbone'
  'Channel'
  'GameView'
  'easel'
], ($, _, Backbone, Channel, ViewBase) ->

  class GameView extends ViewBase

    checkImageCount: (context) ->
      context.imagesLoaded += 1
      if context.imagesLoaded == 3
        context.trigger('imagesLoaded')

    onBackgroundLoaded: (context, img, x, y, regX, regY) ->
      bmp = context.createBitmap(img, x, y, regX, regY)
      context.checkImageCount(context)

    onPlayerLoaded: (context, img, x, y, regX, regY) ->
      bmp = context.createBitmap(img, x, y, regX, regY)
      context.player = bmp
      context.checkImageCount(context)

    onBaddieLoaded: (context, img, x, y, regX, regY) ->
      bmp = context.createBitmap(img, x, y, regX, regY)
      context.baddie = bmp;
      context.checkImageCount(context)

    render: () ->
      @canvas = document.getElementById('main')
      @stage = new createjs.Stage(@canvas)
      @createImage @model.get('bgUrl'), @onBackgroundLoaded, 0, 0, 0, 0
      @createImage \ 
        @model.get('playerUrl'), @onPlayerLoaded, 
        @model.get('playerInitX'), @model.get('playerInitY'), 0, 0
      @createImage \
        @model.get('baddieUrl'), @onBaddieLoaded, 
        @model.get('baddieInitX'), @model.get('baddieInitY'), 0, 0

  return GameView