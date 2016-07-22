'use strict'

{compile} = require('coffee-script')

module.exports = (el, generator) ->
  {builder} = generator
  bare = el.getAttributeValue('bare') or yes
  preserve = (process.env.npm_lifecycle_event is 'standard')

  return builder.htmlElement 'script', {}, [
    builder.text builder.literal(compile el.bodyText, {bare}), no, preserve
  ]
