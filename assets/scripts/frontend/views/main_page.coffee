define [
  'jquery'
  'underscore'
  'backbone'
  'FrontendViewsBaseHtmlPage'
  'text!static_tmp/pages/main.html'
], ($, _, Backbone, BaseHtmlPage, mainPageTemplate) ->

  class MainPage extends BaseHtmlPage
    id: 'main_page'

    render: -> 
      @$el.html(mainPageTemplate)
      @deferredRender () -> Synergy.current.screenInit()
      return @

  return MainPage