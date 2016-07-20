#!/bin/env coffee
'use strict'

Images = require('./lib/images')
Messages = require('./lib/messages')
Tools = require('./lib/tools')

data = new Tools().readVars()


callback = (name) ->
  return (err) ->
    throw err if err?
    new Messages().info 'saved', name
    return


img = new Images(data, callback)

img.backup 'banner'
img.backup('layer', '-layer') if data.layer?
img.blank()
