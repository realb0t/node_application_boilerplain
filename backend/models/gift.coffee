define [
  'require'
  'cs!ModelHelper'
], (require, Helper) ->

  _        = require 'underscore'
  ObjectId = mongoose.Schema.ObjectId

  GiftSchema = new mongoose.Schema

    id:
      type: ObjectId

    gifter_uid:
      type: Number
      validate: Helper.validator.notNull
      #unique: true

    receiver_uid:
      type: Number
      validate: Helper.validator.notNull
      #unique: true

    item_id:
      type: Number
      min: 0
      max: 100000

    paid_at:
      type: Date
      default: null

    received_at:
      type: Date
      default: null

  GiftSchema.methods.isSended = () ->
    this.paid_at != null

  GiftSchema.methods.isReceived = () ->
    this.received_at != null

  GiftModel = mongoose.model('Gift', GiftSchema)

  return {
    Schema: GiftSchema
    Model: GiftModel
  }