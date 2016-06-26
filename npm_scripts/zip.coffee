#!/bin/env coffee
'use strict'


{rm, mkdir, mv} = require('shelljs')
{readdirSync} = require('fs')
zip = require('zip-folder')

do ->

  Tools = require('./lib/tools')
  PUB = './public'

  if (readdirSync(PUB).length < 1)
    msg.error 'nopub'

  data = new Tools().readVars()
  name = "#{ data.meta.name }-#{ data.banner.width }x#{ data.banner.height }"
  dir = "#{ PUB }/#{ name }"

  mkdir dir
  mv "#{ PUB }/*.*", dir

  zip dir, "#{ dir }.zip", (error) ->
    throw error if error?
    rm '-rf', dir
    return

  return
