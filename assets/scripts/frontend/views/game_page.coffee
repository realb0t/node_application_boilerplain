define [
  'jquery'
  'underscore'
  'backbone'
  'FrontendViewsBaseHtmlPage'
  'text!static_tmp/pages/game.html'
], ($, _, Backbone, BaseHtmlPage, pageTemplate) ->

  class GamePage extends BaseHtmlPage
    id: 'game_page'

    render: ->
      $(@el).html(pageTemplate)
      @deferredRender () -> Synergy.current.screenInit(null, 1000)
      return @

  return GamePage