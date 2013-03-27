define [ 
  'require' 
  'cs!ModelHelper'
  'cs!PrototypeModel'
], (require, Helper, Prototype) ->

  _ = require 'underscore'

  ItemSchema = new mongoose.Schema

    item_id:
      type: Number
      min: 0
      max: 1000000000
      validate: Helper.validator.notNull

    quantity:
      type: Number
      min: 0
      validate: Helper.validator.notNull
      default: 0

    state:
      type: Number
      min: 0
      default: 0

    state_live:
      type: Number
      default: 0

    created_at:
      type: Date
      default: Date.now

    updated_state_at:
      type: Date
      default: Date.now

    outputs:
      type: [Prototype.Schema]

  ItemModel = mongoose.model('Item', ItemSchema)

  return {
    Schema: ItemSchema
    Model: ItemModel
  }