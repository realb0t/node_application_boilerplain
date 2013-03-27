define [
  'jquery'
  'underscore'
  'backbone'
  'FrontendViewsBaseHtmlPage'
  'text!static_tmp/pages/help.html'
], ($, _, Backbone, BaseHtmlPage, pageTemplate) ->

  class HelpPage extends BaseHtmlPage
    id: 'help_page'

    render: ->
      $(@el).html(pageTemplate)
      @deferredRender () -> Synergy.current.screenInit(null, 1000)
      return @

  return HelpPage