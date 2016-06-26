#!/bin/env coffee
'use strict'


{rm, test} = require('shelljs')

do ->
  VARS = 'app/variables.cson'
  targets = ['assets', 'partials', 'scripts', 'styles']

  rm('-f', VARS) if test('-f', VARS)
  rm('-f', "app/#{ target }/*.*") for target in targets
  rm '-f', 'public/*.*'
  return
