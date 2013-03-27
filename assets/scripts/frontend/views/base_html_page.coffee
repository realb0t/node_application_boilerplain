define [
  'jquery'
  'underscore'
  'backbone'
  'FrontendViewsBasePage'
], ($, _, Backbone, BasePage) ->

  class BaseHtmlPage extends BasePage
    tagName: 'section'
    className: 'page'

  return BaseHtmlPage