define (require) ->

  _ = require 'underscore'

  Helper = 
    validator:
      notNull: (val) -> val != null

  return Helper