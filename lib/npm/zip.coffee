#!/bin/env coffee
'use strict'


{rm, mkdir, mv} = require('shelljs')
{readdirSync} = require('fs')
zip = require('zip-folder')

PUBLIC = './public'

do ->
  msg.error('nopub') if (readdirSync(PUBLIC).length < 1)

  Tools = require('./lib/tools')
  data = new Tools().readVars()
  dir = "#{ PUBLIC }/#{ data.meta.name }"

  mkdir dir
  mv "#{ PUBLIC }/*.*", dir

  zip dir, "#{ dir }.zip", (error) ->
    throw error if error?
    rm '-rf', dir
    return

  return
