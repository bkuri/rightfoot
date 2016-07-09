'use strict'

template = require('./template.marko')

exports.renderer = (input, output) ->
  console.log JSON.stringify input, '\t', null
  template.render input, output
