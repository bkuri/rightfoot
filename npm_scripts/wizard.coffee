#!/bin/env coffee
'use strict'

{find} = require('lodash')
{prompt} = require('inquirer')
{readdirSync} = require('fs')
{version} = require('../package.json')
Messages = require('./lib/messages')
UtilityBelt = require('./lib/utilities')
WizardQuestions = require('./lib/questions')

TEMPLATES = 'app/assets/templates'

class Wizard
  menu: =>
    prompt(@questions.menu()).then (answers) =>
      switch answers.choice
        when 'public'
          @utils.cleanUp()

        when 'restart'
          prompt(@questions.confirm()).then (answers) =>
            return unless answers.restart
            @utils.cleanUp yes, yes
            @unitQuestions 'banner'

        when 'server'
          @utils.startServer()

        when 'snapshot'
          @utils.zip()

    return


  unitQuestions: (name, extraLayer=no) =>
    @msg.info 'subtitle', name

    prompt(@questions.nextRound()).then (answers) =>
      {width, height, libraries, sticky, x, y, z} = answers
      unit = {width, height, libraries, sticky, x, y, z}
      @data[name] = answers

      # clean up old files
      @utils.cleanUp yes, yes

      if extraLayer
        @utils.copyFiles ['layer.coffee'], 'app/scripts'
        @utils.copyFiles ['layer.marko']

      else
        @utils.writeVars @data

      # TODO: copy all template-related assets
      @utils.copyFiles ['app.styl'], 'app/styles'
      @utils.copyFiles ['banner.coffee'], 'app/scripts'
      @utils.copyFiles ['banner.marko']
      @utils.copyFiles ['head.marko'], 'app/partials'

      @menu()
    return


  constructor: (@questions = new WizardQuestions()) ->
    @msg = new Messages()
    @utils = new UtilityBelt()

    @msg.info 'title', version

    unless @utils.foundVars()
      prompt(@questions.firstRound readdirSync(TEMPLATES)).then (answers) =>
        {lang, name, type} = answers
        meta = {lang, name, type}

        ###
        {border, color, gravity, quality, source} = answers
        image = {border, color, gravity, quality, source}
        ###
        image = border: 1, color: '#eee', gravity: 'Center', quality: 85, source: 'logo2'
        hasLayer = (find readdirSync("#{ TEMPLATES }/#{ type }"), (f) -> f.match(/layer/))?

        @data = {meta, image}
        @unitQuestions 'banner', hasLayer

      return

    else @menu()
    return

new Wizard()
