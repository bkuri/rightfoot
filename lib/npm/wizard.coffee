'use strict'

{exit, ls} = require('shelljs')
{prompt} = require('inquirer')
{readdirSync} = require('fs')
{version} = require('../../package.json')
Messages = require('./lib/messages')
Questions = require('./lib/questions')
Tools = require('./lib/tools')

ASSETS = 'lib'
INIT = "#{ ASSETS }/init"
PARTIALS = "#{ ASSETS }/partials"
TEMPLATES = "#{ ASSETS }/templates"


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
      @data = {meta, image}

      setTimeout =>
        @stage ls("#{ TEMPLATES }/#{ type }/*.marko").concat('preview.marko')
        return
      , 100
      return

    return


  menu: =>
    prompt(@questions.menu()).then (answers) =>
      switch answers.choice
        when 'exit' then exit(0)
        when 'scrub' then @scrub(answers.confirm)
        else @tools.run(answers.choice)

      return

    return


  process: =>
    {meta, preview} = @data

    @tools
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

    @msg.info 'subtitle', name

    prompt(@questions.nextStage name).then (answers) =>
      @data[name] = unless (name is 'preview') then answers
      else answers.preview

      setTimeout =>
        if names.length then @stage(names) else @process()
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
