#!/usr/bin/env coffee
'use strict'


Images = require('./lib/images')
Tools = require('./lib/tools')

do ->
  tools = new Tools()
  data = tools.readVars()
  img = new Images(data)

  img.backup 'banner'
  img.backup('layer', '-layer') if data.layer?
  img.blank()
  return
