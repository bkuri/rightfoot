'use strict'

stylus = require('stylus')


module.exports = (el, generator) ->
  {builder} = generator
  preserve = (process.env.npm_lifecycle_event is 'standard')

  css = stylus(el.bodyText)
    .set 'paths', el.getAttributeValue('paths') or []
    .render()

  return builder.htmlElement 'style', {}, [
    builder.text builder.literal(css), no, preserve
  ]
