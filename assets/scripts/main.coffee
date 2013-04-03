require.config
  urlArgs: "bust=" + (new Date()).getTime()
  waitSeconds: 50
  baseUrl: '/scripts/'

  shim: {
    easel: {
      exports: 'createjs'
    }
    tween: {
      deps: ['easel'],
      exports: 'Tween'
    }
  },
  paths: 
    'easel': '/javascript/createjs/easel',
    'tween': '/javascript/createjs/tween',

    # plugins
    'text': '/javascript/text'
    'order': '/javascript/order'
    'DomReady': '/javascript/dom_ready'
    'use': '/javascript/use'

    # vendors
    'loader': 'vendor/loader'
    'underscore': 'vendor/underscore/underscore'
    'backbone': 'vendor/backbone/backbone'
    'jwerty': 'vendor/jwerty/jwerty'

    'jquery': '/javascript/jquery'
    'json2': '/javascript/json2'
    'modernizr': '/javascript/modernizr'
    'threejs': '/javascript/three'
    'kinectjs': '/javascript/kinect'
    'stats': '/javascript/stats'
    'peer': '/javascript/peer'
    'sock': '/javascript/sock'

    'Frontend': 'frontend'
    'FrontendViews': 'frontend/views'
    'FrontendRouter': 'frontend/router'
    'FrontendViewsBasePage': 'frontend/views/base_page'
    'FrontendViewsBaseHtmlPage': 'frontend/views/base_html_page'
    'FrontendViewsMainPage': 'frontend/views/main_page'
    'FrontendViewsHelpPage': 'frontend/views/help_page'
    'FrontendViewsChatPage': 'frontend/views/chat_page'
    'FrontendViewsChannelsPage': 'frontend/views/channels_page'
    'FrontendViewsDemoPage': 'frontend/views/demo_page'
    'FrontendViewsUnsupportPage': 'frontend/views/unsupported_page'
    
    'Channel': 'channel'
    'ChannelPeer': 'channel/peer'
    'ChannelSock': 'channel/sock'

    'Detector': 'detector'
    'DomHandler': 'dom_handler'
    'Plural': 'plural'

    'static_tmp': '../static_tmp'

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


    'GameView': 'game/view'
    'GameModel': 'game/model'
    'GameController': 'game/controller'

    'GameViewExample': 'game/example/view'
    'GameModelExample': 'game/example/model'
    'GameControllerExample': 'game/example/controller'

require [
  'DomReady'
  'Frontend'
], (domReady, Frontend) -> 
  domReady.withResources () -> Frontend.initialize()
