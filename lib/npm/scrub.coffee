'use strict'

{rm, test} = require('shelljs')


do ->
  rm('-f', "app/#{ sub }/*.*") for sub in ['assets', 'scripts', 'styles']
  rm('-f', 'app/*.*')
  rm '-f', "#{ sub }/*.*" for sub in ['public', 'vendor']
  return
