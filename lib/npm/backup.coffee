'use strict'

{exec} = require('shelljs')
tools = require('./lib/tools')


do ->
  data = tools.readVars()

  exec "rsync -avh --delete app/ saved/#{ data.meta.name }"
  return
