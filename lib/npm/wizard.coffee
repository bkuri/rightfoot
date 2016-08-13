'use strict'

{exit, ls} = require('shelljs')
{prompt} = require('inquirer')
{readdirSync} = require('fs')
{version} = require('../../package.json')
questions = require('./lib/questions')
msg = require('./lib/messages')
tools = require('./lib/tools')

ASSETS = 'lib'
INIT = "#{ ASSETS }/init"
PARTIALS = "#{ ASSETS }/partials"
TEMPLATES = "#{ ASSETS }/templates"


class Wizard
  begin: =>
    prompt(questions.firstStage readdirSync(TEMPLATES)).then (answers) =>
      {lang, name, type} = answers
      meta = {lang, name, type}

      ###
      {border, color, gravity, quality, source} = answers
      image = {border, color, gravity, quality, source}
      ###
      image = border: 1, color: '#eee', gravity: 'Center', quality: 85, source: 'logo2'
      @data = {meta, image}

      setTimeout =>
        @stage ls("#{ TEMPLATES }/#{ type }/*.marko").concat('preview.marko')
        return
      , 100
      return

    return


  menu: =>
    prompt(questions.menu(@saved)).then (answers) =>
      switch answers.choice
        when 'begin' then @begin()
        when 'exit' then exit(0)
        when 'load' then tools.load(answers.name, answers.backup)
        when 'scrub' then tools.scrub(answers.backup)
        else tools.run(answers.choice)

      return

    return


  process: =>
    {meta, preview} = @data

    tools
      .copy "#{ INIT }/app.styl"
      .copy "#{ INIT }/preview/preview.footer.jpg", preview
      .copy "#{ INIT }/preview/preview.header.jpg", preview
      .copy "#{ INIT }/preview/preview.marko", preview, 'index'
      .copy "#{ INIT }/preview/preview.styl", preview
      .copyFolder "#{ TEMPLATES }/#{ meta.type }"
      .writeVars @data

    setTimeout (=> @menu()), 100
    return


  stage: (names) =>
    path = names.shift()
    name = path.match(/([^/]+)\.marko$/)[1]

    msg.info 'subtitle', name

    prompt(questions.nextStage name).then (answers) =>
      @data[name] = unless (name is 'preview') then answers
      else answers.preview

      setTimeout =>
        if names.length then @stage(names) else @process()
        return
      , 100

      return

    return


  constructor: ->
    @saved = ls('saved')

    tools.clear()
    msg.info 'title', version
    if (tools.foundFile() or (@saved.length > 0)) then @menu() else @begin()
    return


new Wizard()
