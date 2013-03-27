requirejs = require 'requirejs'
amdefine  = require 'amdefine'
nconf     = require 'nconf'


global.__env        = 'development'
global.__nconf      = nconf
global.define       = amdefine(module)
global.mongoose     = require('mongoose')
global.noflo        = require 'noflo'
global.crypto       = require 'crypto'
global.__app_root   = __dirname
global.__soc_config = (soc_env) ->
  nconf['synergy'][soc_env][__env]

nconf.env().argv().file(__dirname + '/config/server.json')

mongoose.connect('mongodb://localhost/fight_database')

requirejs.config
  baseUrl: __dirname
  nodeRequire: require
  paths: nconf.get('requirejs')['paths']

requirejs ['cs!ServerBinding'], (server) ->

  db = mongoose.createConnection('localhost', 'test')
  db.on 'error', console.error.bind(console, 'connection error:')
  db.once 'open', () ->
    dispatcher = server.produceDispatcher()
    dispatcher.dispatchHandler(db)
    dispatcher.dispatchRouter(db)
