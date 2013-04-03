define (require) ->

  _       = require 'underscore'
  logger  = require('tracer').console()

  Synergy = require 'cs!Synergy'
  User    = require 'cs!UserModel'

  class RequestDispatcher

    constructor: (@app, @socket, @params) ->  

      @app.param 'socialType', (req, res, next) ->
        Synergy.Backend.auth req.params.socialType, req.params, 
          success: (socialType, uid) ->
            req.user = uid: uid
            req.socialType = socialType
            req.user = User.Model.auth(uid, socialType)
            next()
          failure: (error_message) ->
            next new Error('Failure Social.Backend#auth' + error_message)

    dispatchHandler: () ->

      @socket.on 'connection', (conn) =>

        # Heroku hack
        #t = setInterval () ->
        #  try
        #    conn._session.recv.didClose()
        #  catch x
        #    console.log(x)
        #, 15000
        #conn.on 'close', () -> 
        #  clearInterval t
        
        conn.on 'data', (message) => 
          logger.info "Message: " + message
          conn.write "pong" if message == 'ping'

        conn.write 'welcome'

      @socket.installHandlers @app, prefix: '/echo'
      
      return @

    dispatchRouter: () ->

      console.log ' [*] Listening on 0.0.0.0:9999'
      @app.listen 9999, '0.0.0.0'

      @app.get '/:socialType/test', (req, res) =>
        console.log(@params)
        res.render('index_test')

      @app.get '/:socialType/', (req, res) => 
        res.render 'index', 
          current_user: @current_user

      @app.get '/:socialType/user/avalible_friends.json', (req, res) =>
        uids = req.query.uids || []
        uids = _(uids).map (value) -> parseInt(value)
        res.contentType('application/json')
        res.json { avalible_uids: uids }

      return @

  return RequestDispatcher