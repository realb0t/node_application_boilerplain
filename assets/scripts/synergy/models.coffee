define [  
  'jquery'
  'underscore'
  'backbone'
], ($, _, Backbone) ->

  class User extends Backbone.Model
    
    defaults: () ->

      fields = 
        uid          : ''
        small_image  : '/images/avatar.gif'
        middle_image : ''
        first_name   : ''
        last_name    : ''
        token        : ''
        gender       : null
        photo_medium : null
        photo        : null
        game_balance : 0
        real_balance : 0

      return fields

    is_male: () -> 
      false

    isBlank: () ->
      @get('uid') == ''

    gender: () -> 
      if @is_male() then 'male' else 'female'

    full_name: () -> 
      @get('first_name') + ' ' + @get('last_name')

  class Friend extends User

    isFriend: -> true
    isProfile: -> false

  class Friends extends Backbone.Collection
    model: Friend
    fetch: (options = {}) ->
      _(25).times (i) =>
        friend =
          uid          : Date.now() + i
          small_image  : '/images/avatar.gif'
          middle_image : 'Иванович'
          first_name   : 'Иван ' + i
          last_name    : 'Иванов'
          sex          : ((2%i == 0) ? 1 : 2)

        @add(friend)
        
      options.success() if _.isFunction(options.success)

    # Друзья установившие приложение
    avalibleFriends: (callback) ->
      uids = @map (friend) -> 'uids[]=' + friend.get('uid')
      $.get '/vk/user/avalible_friends.json?' + uids.join('&'), (response) =>
        avalible_friends = @select (friend) ->
          _(response.avalible_uids).include friend.get('uid')

        callback(avalible_friends)


    fakeFetch: () ->
    socialFetch: () ->

  class Profile extends User

    isFriend: -> false
    isProfile: -> true
    
    initialize: () ->
      @friends = new Friends()
      @dfdFriends = $.Deferred()
      super()

    friends_each: (callback) ->
      @load_friends() if @friends.length == 0
      $.when(@dfdFriends).done () =>
        @friends.each(callback)

    find_friend: (uid) ->
      @friends.detect (friend) -> friend.get('uid') == uid

    haveCoins: (amount) ->
      @get('game_balance') >= amount

    haveGold: (amount) ->
      @get('real_balance') >= amount

    chargeOfGold: (amount, callbacks) ->
      newRealBalance = @get('real_balance') - amount
      return callbacks['failure'] if newRealBalance < 0
      @set('real_balance', newRealBalance)
      callbacks['success']()

    chargeOfCoins: (amount, callbacks) ->
      newRealBalance = @get('game_balance') - amount
      return callbacks['failure'] if newRealBalance < 0
      @set('game_balance', newRealBalance)
      callbacks['success']()

  return {
    Profile: Profile
    Friends: Friends
    Friend: Friend
  }