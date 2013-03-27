define [
  'order!/javascript/underscore.js'
  'order!/javascript/backbone.js'
], () ->

  underscore = _.noConflict()

  underscore.mixin
    capitalize : (string) ->
      string.charAt(0).toUpperCase() + string.substring(1).toLowerCase()

  return {
    _: underscore
    Backbone: Backbone.noConflict()
  }