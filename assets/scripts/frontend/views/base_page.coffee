define [
  'jquery'
  'underscore'
  'backbone'
  'DomHandler'
], ($, _, Backbone, DomHandler) ->

  class BasePage extends Backbone.View
    tagName: 'section'
    id: 'base_page'

    deferredRender: (callback) ->
      DomHandler '#' + @id, callback

  return BasePage