define [
  'jquery'
  'underscore'
  'backbone'
  'FrontendViewsUnsupportPage'
  'FrontendViewsMainPage'
  'FrontendViewsHelpPage'
  'FrontendViewsChatPage'
  'FrontendViewsChannelsPage'
  'FrontendViewsDemoPage'
], ($, _, Backbone, UnsupportPage, MainPage, HelpPage, ChatPage, ChannelsPage, DemoPage) ->


  class Application extends Backbone.View
    el: $('body')

    events: {
      'click .nav a.main_page': 'onPageByClass'
    }

    onPageByName: (name, event) ->
      event.preventDefault()
      Backbone.history.navigate(name, {trigger: true})

    onPageByClass: (event) ->
      klass = $(event.target).attr('class')
      klass = klass.split('_')[0]
      @onPageByName klass, event

    initialize: (@params) ->

    render: () ->
      $('nav').hide() if @params && @params['hide_nav']

      #friend_feed = new FriendFeed model: Synergy.current.account
      #friend_feed_el = friend_feed.render().el
      #$('footer').append friend_feed_el
      
      return @


  return {
    Application: Application
    MainPage: MainPage
    HelpPage: HelpPage
    UnsupportPage: UnsupportPage
    ChatPage: ChatPage
    ChannelsPage: ChannelsPage
    DemoPage: DemoPage
  }