#!/bin/env coffee
'use strict'

{copy} = require('quickly-copy-file')
{find} = require('lodash')
{green, red, yellow} = require('chalk')
{prompt} = require('inquirer')
{readdirSync, statSync} = require('fs')
{version} = require('../package.json')
WizardQuestions = require('./questions/questions')
{writeFile} = require('fs-cson')

TEMPLATES = 'app/assets/templates'
VARS = 'app/variables.cson'

class Wizard
  cleanUp: (publicOnly=yes) ->
    # TODO

  copyFiles: (files, from='app/assets/init', to='app/assets') ->

    for file in files
      copy "#{from}/#{{file}}", "#{to}/#{file}"
        .catch (error) -> throw error

    return


  menu: =>
    prompt(@questions.menu()).then (answers) ->
      {choice} = answers
      console.log choice

    return


  unitQuestions: (name, extraLayer=no) =>
    console.log green "\n#{name} settings".toUpperCase()

    prompt(@questions.nextRound()).then (answers) =>
      {width, height, libraries, sticky, x, y, z} = answers
      unit = {width, height, libraries, sticky, x, y, z}
      @data[name] = answers

      # TODO: clean up old files

      unless extraLayer
        writeFile VARS, @data, (error) ->
          throw error if error?
          console.log green """
            \nSettings saved to '#{VARS}'. You can always edit the find
            manually or run this wizard again to start over.\n
          """
      else
        @copyFiles ['layer.coffee', 'layer.marko']

      # TODO: copy all template-related assets

      @menu()
    return


  constructor: (@questions = new WizardQuestions()) ->
    console.log green "Weborama template studio v#{version}\n"

    unless statSync(VARS)?
      prompt(@questions.firstRound readdirSync(TEMPLATES)).then (answers) =>
        {lang, name, type} = answers
        meta = {lang, name, type}

        ###
        {border, color, gravity, quality, source} = answers
        image = {border, color, gravity, quality, source}
        ###
        image = border: 1, color: '#eee', gravity: 'center', quality: 85, source: 'logo2'
        hasLayer = (find readdirSync("#{TEMPLATES}/#{type}"), (f) -> f.match(/layer/))?

        @data = {meta, image}
        @unitQuestions 'banner', hasLayer
        return

    else @menu()
    return


new Wizard()
