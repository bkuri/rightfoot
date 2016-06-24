#!/bin/env coffee
'use strict'


{exit} = require('shelljs')
{find} = require('lodash')
{prompt} = require('inquirer')
{readdirSync} = require('fs')
{version} = require('../package.json')
{writeFile} = require('fs-cson')
Questions = require('./lib/questions')
Messages = require('./lib/messages')
Tools = require('./lib/tools')

TEMPLATES = 'app/assets/templates'


class Wizard
  begin: =>
    prompt(@questions.firstStage readdirSync(TEMPLATES)).then (answers) =>
      {lang, name, type} = answers
      meta = {lang, name, type}

      ###
      {border, color, gravity, quality, source} = answers
      image = {border, color, gravity, quality, source}
      ###
      image = border: 1, color: '#eee', gravity: 'Center', quality: 85, source: 'logo2'
      hasLayer = (find readdirSync("#{ TEMPLATES }/#{ type }"), (f) -> f.match(/layer/))?

      @data = {meta, image}
      @stage 'banner', hasLayer
      return


  menu: =>
    prompt(@questions.menu()).then (answers) =>
      switch answers.choice
        when 'exit' then exit(0)
        when 'restart' then @restart()
        else @tools.run answers.choice

      return

    return


  scrub: =>
    prompt(@questions.confirm()).then (answers) =>
      return unless answers.confirmed
      @tools.run('scrub', 'scrubbed')
      return

    return


  stage: (name, extraLayer=no) =>
    @msg.info 'subtitle', name

    prompt(@questions.nextStage()).then (answers) =>
      {width, height, libraries, sticky, x, y, z} = answers
      unit = {width, height, libraries, sticky, x, y, z}
      @data[name] = answers

      if extraLayer
        @tools.copy 'layer.coffee'
        @tools.copy 'layer.marko'
        @stage 'layer'
        
      else
        @tools.writeVars @data

      @tools.copy 'app.styl'
      @tools.copy 'banner.coffee'
      @tools.copy 'banner.marko'
      @tools.copy 'head.marko', 'partials'
      @tools.copyFolder @data.meta.type

      @menu()
      return

    return


  constructor: ->
    @msg = new Messages()
    @questions = new Questions()
    @tools = new Tools()

    @tools.clear()
    @msg.info 'title', version
    if @tools.foundVars() then @menu() else @begin()
    return


new Wizard()
