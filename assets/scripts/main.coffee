require.config
  urlArgs: "bust=" + (new Date()).getTime()
  waitSeconds: 50
  baseUrl: '/scripts/'
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

    'Frontend': 'frontend'
    'FrontendViews': 'frontend/views'
    'FrontendViewsBasePage': 'frontend/views/base_page'
    'FrontendViewsBaseHtmlPage': 'frontend/views/base_html_page'
    'FrontendViewsMainPage': 'frontend/views/main_page'
    'FrontendViewsHelpPage': 'frontend/views/help_page'
    'FrontendViewsUnsupportPage': 'frontend/views/unsupported_page'
    'FrontendRouter': 'frontend/router'

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

require [
  'DomReady'
  'Frontend'
], (domReady, Frontend) -> 
  domReady.withResources () -> Frontend.initialize()
