define [
  'jquery'
  'underscore'
  'backbone'
  'ChannelPeer'
  'ChannelSock'
], ($, _, Backbone, PeerChannel, SockChannel) ->

  return {
    peer: () -> 
      @peer = @peer || new PeerChannel(debug: true)

    sock: () -> 
      @sock = @sock || new SockChannel()
  }