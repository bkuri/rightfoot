'use strict'

{compile} = require('coffee-script')

exports.render = (input, output) ->
  {bare} = input

  source = output.captureString ->
    return input.renderBody?(output) or ''

  output.write "<script>#{ compile(source, {bare}) }</script>"
  return
