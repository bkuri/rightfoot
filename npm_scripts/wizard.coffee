#!/bin/env coffee
'use strict'


WizardQuestions = require('./questions/questions')
{prompt} = require('inquirer')
{writeFile} = require('fs-cson')


PATH = 'app/variables.cson'

class Prompt
  data: {}

  unitQuestions: (name) =>
    console.log "\n#{name} settings".toUpperCase()

    console.log JSON.stringify(@data, null, '  ')

    prompt(@questions.nextRound @data.meta.type).then (answers) =>
      {width, height, libraries, offset, sticky, zindex} = answers
      unit = {width, height, libraries, offset, sticky, zindex}
      @data[name] = answers

      # TODO: check qType against templates that require a layer
      last = (name isnt 'banner')

      unless last then @unitQuestions('layer')
      else writeFile PATH, @data, (error) ->
        throw error if error?
        console.log "\nSettings saved to '#{PATH}'. You can always edit the find manually or run this script again to start over.\n"

      return
    return


  constructor: (@questions) ->
    prompt(@questions.firstRound()).then (answers) =>
      {name, lang, type} = answers
      meta = {name, lang, type}

      ###
      {border, color, gravity, quality, source} = answers
      image = {border, color, gravity, quality, source}
      ###
      image = border: 1, color: '#eee', gravity: 'center', quality: 85, source: 'logo2'

      @data = {meta, image}
      @unitQuestions 'banner'
      return

new Prompt new WizardQuestions()
