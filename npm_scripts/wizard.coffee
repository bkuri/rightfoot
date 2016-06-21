#!/bin/env coffee
'use strict'

{find} = require('lodash')
{green, red, yellow} = require('chalk')
{prompt} = require('inquirer')
{readdirSync} = require('fs')
WizardQuestions = require('./questions/questions')
{writeFile} = require('fs-cson')
{version} = require('../package.json')

TEMPLATES = 'app/assets/templates'
VARS = 'app/variables.cson'

class Prompt
  data: {}

  unitQuestions: (name, layer) =>
    console.log green "\n#{name} settings".toUpperCase()

    prompt(@questions.nextRound()).then (answers) =>
      {width, height, libraries, sticky, x, y, z} = answers
      unit = {width, height, libraries, sticky, x, y, z}
      @data[name] = answers

      unless layer then writeFile VARS, @data, (error) ->
        throw error if error?
        console.log green "\nSettings saved to '#{VARS}'. You can always edit the find manually or run this script again to start over.\n"
      else @unitQuestions('layer')
    return

  constructor: (@questions = new WizardQuestions()) ->
    console.log yellow "Weborama template studio v#{version}"

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

new Prompt()
