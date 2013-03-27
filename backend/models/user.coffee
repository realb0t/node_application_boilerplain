define [
  'require'
  'cs!ModelHelper'
  'cs!Synergy'
], (require, Helper, Synergy) ->

  _ = require 'underscore'

  UserSchema = new mongoose.Schema

    # TODO: совместить уникальый индекс с UID
    social_type_id: 
      type: Number
      min: 0
      max: 3
      index: true
      default: 0
    
    uid: 
      type: Number
      validate: Helper.validator.notNull
      unique: true
    
    socket_key: 
      type: String
      validate: Helper.validator.notNull
      unique: true

    incoming_gifts_count:
      type: Number
      min: 0
      default: 0

    game_balance:
      type: Number
      min: 0
      default: 0

    real_balance:
      type: Number
      min: 0
      default: 0

    bonus_balance:
      type: Number
      min: 0
      default: 0

    created_at:
      type: Date
      default: Date.now

    lanched_at:
      type: Date
      default: Date.now

    updated_at:
      type: Date
      default: Date.now

    social_updated_at:
      type: Date
      default: Date.now

    tutorial_completed_at:
      type: Date
      default: null

    tutorial_step:
      type: Number
      default: 0
    #items: [ Item ]

  UserSchema.methods.social_type = () ->
    Synergy.typeById(@social_type_id)

  UserSchema.methods.api = () ->
    unless @api
      @api = Synergy.apiById(@social_type_id)

    return @api

  UserSchema.statics.findByUid = (uid, social_type) =>
  UserSchema.statics.auth = (uid, social_type) ->
    {
      social_type_id: 2
      uid: uid
      social_type: social_type
    }

  UserModel = mongoose.model('User', UserSchema)

  return {
    Schema: UserSchema
    Model: UserModel
  }