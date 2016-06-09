#!/bin/env coffee
'use strict'


mkdirp = require('mkdirp')
rimraf = require('rimraf')
path = './public'


rimraf path, (err) ->
  throw err if err

  mkdirp path, (err) ->
    throw err if err
