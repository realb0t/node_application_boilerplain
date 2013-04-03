define [
  'jquery'
  'underscore'
  'backbone'
  'Channel'
], ($, _, Backbone, Channel) ->

  class GameModel extends Backbone.Model

    defaults:
      refreshRate: 60

  return GameModel