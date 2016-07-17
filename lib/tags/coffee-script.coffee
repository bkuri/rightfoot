'use strict'

{compile} = require('coffee-script')

module.exports = (el, generator) ->
  {builder} = generator
  bare = el.getAttributeValue('bare') or yes
  preserve = (process.env.npm_lifecycle_event is 'standard')
  indent = if preserve then 2 else 0

  return builder.htmlElement 'script', {indent}, [
    builder.text builder.literal(compile el.bodyText, {bare}), no, preserve
  ]
