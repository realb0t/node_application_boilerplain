define [
  'jquery'
  'underscore'
  'backbone'
  'Channel'
  'GameController'
  'GameModelExample'
  'GameViewExample'
  'easel'
], ($, _, Backbone, Channel, ControllerBase, GameModel, GameView) ->

  class GameController extends ControllerBase

    constructor: () ->
      @model = new GameModel()
      @view  = new GameView(model: @model, controller: @)

    setupControls: () ->
      moveAmount = @model.get('playerMoveAmount')

      $(document).keydown (e) =>
        if e.keyCode == 65
          @view.player.x -= moveAmount;

        if e.keyCode ==  68
          @view.player.x += moveAmount;

    childTick: () ->
      @view.baddie.y += 3

  return GameController