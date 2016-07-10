'use strict'

stylus = require('stylus')

exports.render = (input, output) ->
  source = output.captureString ->
    return input.renderBody?(output) or ''

  stylus(source)
    .set 'compress', input.compress or no
    .set 'paths', input.paths or []

    .render (error, css) ->
      if error?
        output.write "<!-- STYLUS-ERROR: #{ error } -->"
        return

      output.write "<style>#{ css }</style>"
      return

  return
