'use strict'

{rm, test} = require('shelljs')


do ->
  targets = ['assets', 'scripts', 'styles']

  rm('-f', "app/#{ target }/*.*") for target in targets
  rm('-f', 'app/*.*')
  rm '-f', 'public/*.*'
  rm '-f', 'vendor/*.*'
  return
