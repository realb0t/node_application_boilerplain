define [
  'jquery'
  'underscore'
  'backbone'
  'FrontendViews'
  'SynergyHelper'
], ($, _, Backbone, Views, SynergyHelper) ->

  Router = { current_page: null }

  class Router.Unsupport extends Backbone.Router

    routes: '*action': 'showUnsupportPage'

    showUnsupportPage: ->
      Router.current_page = new Views.UnsupportPage()
      Router.current_page.render()
    

  class Router.Support extends Backbone.Router

    routes:
      'main':     'showMain'     # Главная страница
      'help':     'showHelp'     # Страница помощи
      'chat':     'showChat'     # Страница тестирования PeerJS
      'demo':     'showDemo'     # Страница тестирования 2D Canvas
      'channels': 'showChannels' # Страница проверки PeerJS with SockJS
      '*actions': 'showMain'

    preReset: ->
      Synergy.current.account.off('refresh_real_balance')

    pageWithLog: (klass, options = {}) ->
      @preReset()
      AccessLog.pushWithEnv('show' + klass)
      @page = new Views[klass + 'Page'](options) 
      $('article').html(@page.render().el)

    showMain:     -> @pageWithLog('Main')
    showHelp:     -> @pageWithLog('Help')
    showChat:     -> @pageWithLog('Chat')
    showDemo:     -> @pageWithLog('Demo')
    showChannels: -> @pageWithLog('Channels')

  return Router