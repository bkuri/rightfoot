#!/bin/env coffee
'use strict'


{exec, fork} = require('child_process')
{stat} = require('fs')

callback = (error, stdout, stderr) ->
  console.log stdout

stat 'app/variables.cson', (err, stats) ->
  if err? then fork('npm', ['run', 'wizard'], callback)
  else exec('brunch', ['watch', '--server'], callback)
