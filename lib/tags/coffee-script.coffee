'use strict'

{compile} = require('coffee-script')

module.exports = (el, generator) ->
  {builder} = generator
  bare = el.getAttributeValue('bare') or yes

  return builder.htmlElement 'script', {}, [
    builder.text builder.literal(compile el.bodyText, {bare})
  ]
