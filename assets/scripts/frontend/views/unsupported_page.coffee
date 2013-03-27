define [
  'jquery'
  'underscore'
  'backbone'
  'FrontendViewsBaseHtmlPage'
  'text!static_tmp/pages/unsupport.html'
], ($, _, Backbone, BaseHtmlPage, pageTemplate) ->

  class UnsupportPage extends BaseHtmlPage
    id: 'unsupport_page'

    render: ->
      @$el.html(pageTemplate)
      @deferredRender () -> Synergy.current.screenInit()

  return UnsupportPage