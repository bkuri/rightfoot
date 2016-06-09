#!/bin/env coffee


{readFile} = require('fs-cson')
{zip} = require('bauer-zip')


readFile 'app/variables.cson', (readErr, data) ->
  throw readErr if readErr?
  path = "public/#{data.name}.zip"

  zip './public', path, (zipErr) ->
    throw zipErr if zipErr?
    console.log "-> file saved as #{path}"
