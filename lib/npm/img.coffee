'use strict'

Images = require('./lib/images')
Messages = require('./lib/messages')
Tools = require('./lib/tools')


callback = (name) ->
  return (err) ->
    throw err if err?
    new Messages().info 'saved', name
    return

do ->
  data = new Tools().readVars()
  img = new Images(data, callback)

  img.backup 'banner'
  img.backup('layer', '-layer') if data.layer?
  img.blank()
  return
