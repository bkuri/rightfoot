#!/usr/bin/env coffee
'use strict'


img = new require('./lib/images')()
tools = new require('./lib/tools')()
data = tools.readVars()


img.backup()
img.backup(data.layer, '-layer') if data.layer?
img.blank()
