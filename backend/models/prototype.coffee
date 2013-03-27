define [ 
  'require' 
  'cs!ModelHelper'
], (require, Helper) ->

  _ = require 'underscore'

  PrototypeSchema = new mongoose.Schema

    item_id:
      type: Number
      min: 0
      max: 1000000000
      validate: Helper.validator.notNull

    created_at:
      type: Date
      default: Date.now

    quantity:
      type: Number
      default: 1
      validate: Helper.validator.notNull

  PrototypeModel = mongoose.model('Prototype', PrototypeSchema)

  return {
    Schema: PrototypeSchema
    Model: PrototypeModel
  }