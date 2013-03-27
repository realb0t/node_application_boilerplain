define [
  'require'
  'cs!Wrapper'
], (require, Wrapper) ->

  _ = require 'underscore'

  Synergy =
    avalibleSocialTypes:
      odkl: 'ok'
      vk: 'vk'
    socialIds:
      ok: 1
      vk: 2
      mm: 3

  Synergy.idByType = (type) ->
    Synergy.socialIds[type]

  Synergy.idByKey = (key) ->
    type = Synergy.avalibleSocialTypes[key]
    Synergy.idByType(type)

  Synergy.keyById = (id) ->
    _(Synergy.socialIds).chain().map (v, k) -> 
        [k, v]
      .select (el) ->
        el[1] == id
      .first().first().value()

  Synergy.keyByType = (type) ->
    Synergy.avalibleSocialTypes[type]

  Synergy.typeByKey = (key) ->
    _(Synergy.avalibleSocialTypes).chain()
      .map (v, k) -> 
        [k, v]
      .select (el) ->
        el[1] == key
      .first().first().value()

  Synergy.typeById = (id) ->
    key = Synergy.keyById(id)
    Synergy.typeByKey(key)


  Synergy.apiById = (id) ->
    type = Synergy.typeById(id)
    return Wrapper[type] if Wrapper[type]

  Synergy.Backend =
      currentSocialType: null
      auth: (socialType, params, callbacks) ->
        if _(Synergy.avalibleSocialTypes).chain().keys().include(socialType).value()
          Synergy.Backend.currentSocialType = Synergy.avalibleSocialTypes[socialType]
          callbacks['success'](socialType, (params.uid || '123123123'))
        else
          callbacks['failure']('Not allowed social type: ' + socialType)

  return Synergy