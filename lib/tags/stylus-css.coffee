'use strict'

axis = require('axis')
stylus = require('stylus')


module.exports = (el, generator) ->
  {builder} = generator
  preserve = (process.env.npm_lifecycle_event is 'standard')

  css = stylus(el.bodyText)
    .use axis()
    .set 'paths', el.getAttributeValue('paths') or []
    .render()

  return builder.htmlElement 'style', {}, [
    builder.text builder.literal(css), no, preserve
  ]
