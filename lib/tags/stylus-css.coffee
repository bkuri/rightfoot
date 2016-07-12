'use strict'

stylus = require('stylus')

module.exports = (el, generator) ->
  {builder} = generator

  css = stylus(el.bodyText)
    .set 'compress', el.getAttributeValue('compress') or no
    .set 'paths', el.getAttributeValue('paths') or []
    .render()

  return builder.htmlElement 'style', {}, [
    builder.text builder.literal(css)
  ]
