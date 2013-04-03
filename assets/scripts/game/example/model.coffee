define [
  'jquery'
  'underscore'
  'backbone'
  'Channel'
  'easel'
], ($, _, Backbone, Channel) ->

  class GameModel extends Backbone.Model

    defaults:
      refreshRate: 60
      bgUrl: '/images/mario/world.gif'
      playerInitX: 300
      playerInitY: 470
      playerMoveAmount: 6
      playerUrl: '/images/mario/mario.gif'
      baddieInitX: 500
      baddieInitY: -500
      baddieMoveAmount: 8
      baddieUrl: '/images/mario/goomba.png'

  return GameModel