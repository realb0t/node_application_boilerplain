require.config
  urlArgs: "bust=" + (new Date()).getTime()
  baseUrl: '/scripts/'
  waitSecods: 50
  paths:

    # plugins
    'text': '/javascript/text'
    'order': '/javascript/order'
    'DomReady': '/javascript/dom_ready'
    'use': '/javascript/use'

    # vendors
    'loader': 'vendor/loader'
    'underscore': 'vendor/underscore/underscore'
    'backbone': 'vendor/backbone/backbone'
    
    'jquery': '/javascript/jquery'
    'json2': '/javascript/json2'
    'modernizr': '/javascript/modernizr'
    'threejs': '/javascript/three'
    'kinectjs': '/javascript/kinect'
    'stats': '/javascript/stats'

    'mocha': '/javascript/mocha'
    'chai': '/javascript/chain'
    'sinon-chai': '/javascript/sinon_chain'
    'sinon': '/javascript/sinon'

    'static_tmp': '../static_tmp'

    'Frontend': 'frontend'
    'FrontendViews': 'frontend/views'
    'FrontViewsBasePage': 'app/views/base_page'
    'FrontViewsBaseHtmlPage': 'app/views/base_html_page'
    'FrontendRouter': 'frontend/router'

    # appliation
    'Detector': 'detector'
    'DomHandler': 'dom_handler'
    'Plural': 'plural'

    # Synergy
    'Synergy': 'synergy'
    'SynergyConfig': '/vk/synergy_config'
    'SynergyProvider': 'synergy/provider'
    'SynergyProducer': 'synergy/producer'
    'SynergyVk': 'synergy/vk'
    'SynergyOk': 'synergy/ok'
    'SynergyHelper': 'synergy/helpers'
    'SynergyCallbacks': 'synergy/callbacks'
    'SynergyModels': 'synergy/models'

    # Tests
    'TestRoot': 'tests/root'
  
  'use': 
    'mocha': 
      'attach': 'mocha'
    'sinon': 
      'attach': 'sinon'

require [
  'require'
  'use!mocha'
  'use!sinon'
  'chai'
  'sinon-chai'
], (require, Mocha, Sinon, chai, sinonChai) ->
  mocha.setup
    ui: 'bdd'
    globals: [ 'setTimeout', 'setInterval', 'clearTimeout', 'clearInterval' ]

  chai.Should()
  chai.use(sinonChai)
  require [ 'TestRoot' ], (TestRoot) -> 
    mocha.run()
