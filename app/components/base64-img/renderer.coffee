'use string'


{fromFile} = require('hasha')
{lookup} = require('mime')
template = require('./template.marko')


exports.renderer = (input, output) ->
  type = lookup(input.src)

  fromFile(input.src, enconding: 'base64').then (data) ->
    template.render {data, type}
    return

  return
