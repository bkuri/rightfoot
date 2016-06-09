#!/bin/env coffee
'use strict'


{readFile} = require('fs-cson')
{zip} = require('bauer-zip')


readFile 'app/variables.cson', (readErr, data) ->
  throw readErr if readErr?
  path = "public/#{data.name}-#{data.width}x#{data.height}.zip"

  zip './public', path, (zipErr) ->
    throw zipErr if zipErr?
    console.log "-> file saved as #{path}"
