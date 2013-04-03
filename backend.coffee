define (require) ->

  express = require 'express'
  sockjs  = require 'sockjs'
  fs      = require 'fs'
  coffee  = require 'coffee-script'
  sass    = require 'sass'

  RequestDispatcher = require 'cs!RequestDispatcher'

  # Config SockJS
  sockjs_opts = sockjs_url: "http://cdn.sockjs.org/sockjs-0.3.min.js"
  socket = sockjs.createServer sockjs_opts

  # Config Express
  app = express.createServer()
  app.configure () ->
    app.set 'views'      , __app_root + '/views'
    app.set 'partials'   , __app_root + '/views/partials'
    app.set 'view engine', 'jade'
    app.use express.errorHandler dumpExceptions: true, showStack: true
    app.use express.static __app_root + '/public'
    app.set 'view options', layout: false

  app.get /^\/scripts((?:[^\/]+\/?)*?)\/(.*?).js/, (req, res) ->
    res.header 'Content-Type', 'application/x-javascript'
    path      = if req.params[0] == '' then '' else "/#{req.params[0]}"
    full_path = "#{__app_root}/assets/scripts#{path}/#{req.params[1]}.coffee"
    console.log 'Compile coffee: ', full_path
    cs = fs.readFileSync full_path, "ascii"
    js = coffee.compile cs 
    res.send js

  app.get /^\/styles((?:[^\/]+\/?)*?)\/(.*?).css/, (req, res) ->
    res.header 'Content-Type', 'text/css'
    path      = if req.params[0] == '' then '' else "/#{req.params[0]}"
    full_path = "#{__app_root}/assets/styles#{path}/#{req.params[1]}.scss"
    console.log 'Compile less: ', full_path
    scss = fs.readFileSync full_path, "ascii"
    css = sass.render scss 
    res.send css

  return {
    produceDispatcher: (params) ->
      new RequestDispatcher app, socket,
        routes: {}
        handlers: {}
  }