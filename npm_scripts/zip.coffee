#!/bin/env coffee
'use strict'


{readFile} = require('fs-cson')
{rename} = require('fs')
{zip} = require('bauer-zip')


readFile 'app/variables.cson', (readErr, data) ->
  throw readErr if readErr?
  name = "#{ data.name }-#{ data.width }x#{ data.height }"
  old = './public'

  rename old, name, (renameErr) ->
    throw renameErr if renameErr?

    zip name, "#{ name }/#{ name }.zip", (zipErr) ->
      throw zipErr if zipErr?

      console.log "-> file saved as public/#{ name }.zip"
      rename "./#{ name }", old
