'use strict'

Images = require('./lib/images')
msg = require('./lib/messages')
tools = require('./lib/tools')


callback = (name) ->
  return (err) ->
    throw err if err?
    msg.info 'saved', name
    return

do ->
  data = tools.readVars()
  img = new Images(data, callback)

  img.backup 'banner'
  img.backup('layer', '-layer') if data.layer?
  img.blank()
  return
