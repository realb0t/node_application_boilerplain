requirejs  = require 'requirejs'
amdefine   = require 'amdefine'
nconf      = require 'nconf'
peer       = require 'peer'

global.__env      = 'development'
global.__nconf    = nconf
global.define     = amdefine(module)
global.mongoose   = require('mongoose')
global.noflo      = require 'noflo'
global.crypto     = require 'crypto'
global.__app_root = __dirname

nconf.env().argv().file(__dirname + '/config/server.json')

mongoose.connect('mongodb://localhost/fight_database')

requirejs.config
  baseUrl: __dirname
  nodeRequire: require
  paths: nconf.get('requirejs')['paths']

requirejs [], () ->

  peer_port = nconf.get('peer')['port']

  PeerServer = peer.PeerServer
  server = new PeerServer({ port: peer_port })
  console.log "Start PeerJS-server on port #{peer_port}"