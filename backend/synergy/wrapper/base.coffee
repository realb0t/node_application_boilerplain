define [
  'require'
], (require) ->

  _ = require 'underscore'
  http = require 'http'

  class WrapperBase

    default_request_option:
      host: 'localhost'
      port: 8080
      path: '/'
      method: 'GET'
      encoding: 'utf8'

    initialize: () ->

    api_request: (options = {}) ->
      options = _(@default_request_option).extend(options)
      success = options['success'] || () ->
      failure = options['failure']
      max_counter = options['max_counter'] || 0

      send_request \
        options,
        success,
        failure,
        0,
        max_counter

    send_request: (options, success, failure, counter, max_counter) ->


      req = http.request options, (res) =>

        console.log('Api request status: ' + res.statusCode)
        console.log('Api request headers: ' + JSON.stringify(res.headers))
        data = ''

        res.setEncoding(options['encoding'])
        res.on 'data', (chunk) =>
          data += chunk

        res.on 'end',  () =>
          response = JSON.parse(data)
          success(response)

      req.on 'error', () =>
        return failure if _.isFunction(failure)
        counter += 1
        if counter < max_counter
          console.warn('Resend api request with options ' + JSON.stringify(options) + ', bacause', e.message)
          
          send_request \
            options,
            success,
            failure,
            0,
            max_counter
        else
          console.error('Error send api request with options ' + JSON.stringify(options) + ', bacause', e.message)

      req.end()

    build_request_str: (params, secret = '') ->
      sorted_params = @sorted_keys(params)
      sig = ''
      join_params = (v, k) -> k+'='+v

      _(sorted_params).map(join_params).join()
      sig = sig + secret
      sig = crypto.createHash('md5').update(sig).digest('hex')
      sorted_params.sig = sig

      request_str = sorted_params.map(join_params).join('&')
      console.log('request with string: ', request_str)
      return request_str

    get_profile: (options) -> @unsupported options, 'get_profile'
    get_friends: (options) -> @unsupported options, 'get_friends'
    get_friend_profiles: (options) -> @unsupported options, 'get_friend_profiles' 
    send_notification: (options) -> @unsupported options, 'send_notification' 
    send_request: (options) -> @unsupported options, 'send_request'

    unsupported: (options, method = 'not_exists') ->
      if _.isFunction(options['failure'])
        options['failure'](error: 'Unsupported method ' + method)
      else
        console.error('Unsupported method ' + method)

    sorted_keys: (obj) ->
      sorted_obj = {}
      keys = _(obj).keys()
      _(keys).each (key) ->
        sorted_obj[key] = obj[key]
      sorted_obj

  return WrapperBase