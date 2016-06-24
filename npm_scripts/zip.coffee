#!/bin/env coffee
'use strict'


{mv} = require('shelljs')
{readdirSync} = require('fs')
{zip} = require('zip-folder')
Messages = require('./messages')


PUB = './public'

@msg.error('nopub') if (readdirSync(PUB).length < 1)

data = @readVars()
name = "#{ data.name }-#{ data.width }x#{ data.height }"

mv PUB, name

zip name, "#{ name }/#{ name }.zip", (error) =>
  throw error if error?
  @msg.info 'zipped', name
  mv "./#{ name }", PUB
  return
