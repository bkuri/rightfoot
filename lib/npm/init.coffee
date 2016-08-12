'use strict'

{mkdir} = require('shelljs')


do ->
  mkdir '-p', ['app', 'public', 'saved']
  return
