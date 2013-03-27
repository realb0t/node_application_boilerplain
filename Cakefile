fs            = require 'fs'
{print}       = require 'util'
{spawn, exec} = require 'child_process'

# ANSI Terminal Colors
bold  = '\x1B[0;1m'
red   = '\x1B[0;31m'
green = '\x1B[0;32m'
reset = '\x1B[0m'

log = (message, color, explanation) -> console.log color + message + reset + ' ' + (explanation or '')

task 'dev', 'Start in "dev" enviropment and watching on CLIENT/SERVER sides code', ->
  options = ['-c', '-b', '-w', '-o', './public/scripts', './assets/scripts']
  client_observer = spawn './node_modules/coffee-script/bin/coffee', options
  client_observer.stdout.pipe process.stdout
  log 'Watching JS-client side', green
  
  options = [ '-w', 'views,server.coffee', '-e', 'js|coffee' , '--nodejs' , '--debug', 'app.coffee' ]
  supervisor = spawn 'supervisor', options
  supervisor.stdout.pipe process.stdout
  log 'Watching JS files and running server', green

  options = []
  styles = exec 'bundle exec sass --trace --compass --watch assets/styles/common.scss:public/styles/common.css', () -> log('compiled')
  #styles = exec 'bundle exec sass --trace --compass assets/styles/common.scss public/styles/common.css', (error, stdout, stderr) ->
  styles.stdout.pipe process.stdout
  log 'Watching SCSS files and running server', green

task 'test', 'Execute server specs', ->
  specs = exec "NODE_ENV=test 
    ./node_modules/.bin/mocha 
    --compilers coffee:coffee-script 
    --require coffee-script 
    --reporter spec 
    --require test/test_helper.coffee 
    --colors
    --debug
  "
  specs.stdout.pipe process.stdout
  specs.stderr.pipe process.stderr
