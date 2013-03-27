define [
  'require'
  'cs!WrapperOk'
  'cs!WrapperVk'
], (require, WrapperOk, WrapperVk) ->

  return {
    #'ok': new WrapperOk(__nconf['synergy']['ok'][__env])
    #'vk': new WrapperVk(__nconf['synergy']['vk'][__env])
  }