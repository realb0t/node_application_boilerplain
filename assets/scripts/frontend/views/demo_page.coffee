define [
  'jquery'
  'underscore'
  'backbone'
  'FrontendViewsBaseHtmlPage'
  'GameViewExample',
  'GameModelExample',
  'GameControllerExample',
  'text!static_tmp/pages/demo.html'
], ($, _, Backbone, BaseHtmlPage, View, Model, Controller, pageTemplate) ->

  class DemoPage extends BaseHtmlPage
    id: 'demo_page'

    initGame: () ->
      @controller = new Controller()
      #@controller.setupTicker()

    render: ->
      $(@el).html(pageTemplate)
      @deferredRender () => 
        Synergy.current.screenInit(null, 1000)
        @initGame()

      return @

  return DemoPage
