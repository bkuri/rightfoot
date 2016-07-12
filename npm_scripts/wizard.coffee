#!/bin/env coffee
'use strict'


{exit, ls} = require('shelljs')
{prompt} = require('inquirer')
{readdirSync} = require('fs')
{version} = require('../package.json')
Messages = require('./lib/messages')
Questions = require('./lib/questions')
Tools = require('./lib/tools')

ASSETS = 'app/assets'
INIT = "#{ ASSETS }/init"
TEMPLATES = "#{ ASSETS }/templates"


class Wizard
  begin: =>
    prompt(@questions.firstStage readdirSync(TEMPLATES)).then (answers) =>
      {lang, name, type} = answers
      meta = {lang, name, type}
      temp = "#{ TEMPLATES }/#{ type }"
      @data = {meta, image}

      ###
      {border, color, gravity, quality, source} = answers
      image = {border, color, gravity, quality, source}
      ###
      image = border: 1, color: '#eee', gravity: 'Center', quality: 85, source: 'logo2'

      @tools
        .copyFolder temp
        .copy "#{ INIT }/app.styl"
        .copy "#{ INIT }/head.marko", 'partials'
        .copy "#{ INIT }/index.marko"
        .copy "#{ INIT }/preview/preview.styl"
        .writeVars @data

      setTimeout (=> @stage ls("#{ temp }/*.marko")), 100
      return

    return

  menu: =>
    prompt(@questions.menu()).then (answers) =>
      switch answers.choice
        when 'exit' then exit(0)
        when 'scrub' then @scrub(answers.confirm)
        else @tools.run answers.choice

      return

    return


  scrub: (confirmed) =>
    @tools.run('scrub', 'scrubbed') if confirmed
    return


  stage: (names) =>
    file = names.shift()
    name = file.match(/([^/]+)\.marko$/)[1]

    @msg.info 'subtitle', name

    prompt(@questions.nextStage()).then (answers) =>
      @data[name] = answers
      path = "#{ INIT }/#{ file }"

      @tools.copy(path, 'partials') if ls(path).length
      @tools.copy file, 'partials'

      setTimeout =>
        unless names.length then @stage names else @menu()
        return
      , 100
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
