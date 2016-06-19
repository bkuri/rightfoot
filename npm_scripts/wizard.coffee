#!/bin/env coffee
'use strict'


{load} = require('cheerio')
{prompt} = require('inquirer')
path = 'app/variables.cson'
request = require('request')
{writeFile} = require('fs-cson')

uri =
  screenad: '//media.adrcdn.com/scripts/screenad_interface_1.0.3_scrambled.js'
  tools: 'http://developer.weborama.nl/tools-downloads/'

PLAIN = 'Standard (from scratch)'

getFormat = (format) ->
  switch format
    when PLAIN then 'banner'
    else format

nonEmpty = (str) ->
  String(str).trim().length > 0

qName =
  message: 'Give this project a name:'
  name: 'name'
  validate: nonEmpty

qLang =
  default: 'en'
  message: 'Which language would you like to use?'
  name: 'lang'
  validate: nonEmpty

qFormat =
  default: PLAIN
  message: 'Banner type:'
  name: 'format'
  validate: nonEmpty

qWidth =
  default: 300
  message: 'Width:'
  name: 'width'
  validate: nonEmpty

qHeight =
  default: 250
  message: 'Height:'
  name: 'height'
  validate: nonEmpty

qLibs =
  choices: []
  message: 'Select the libraries that you would like to use:'
  name: 'libraries'
  type: 'checkbox'
  when: (answers) -> (answers.format is PLAIN)

request uri: uri.tools, (reqErr, resp, body) ->
  throw reqErr if reqErr?
  $ = load(body)

  $('tr', '#content').each (index, item) ->
    return if (index is 0)
    name = ''

    $('td', item).each (i) ->
      value = $(@).text().trim()

      switch
        when (i is 0) then name += "#{value} v"
        when (i is 1) then name += value
        else qLibs.choices.push {name, value}

  prompt([qName, qLang, qFormat, qLibs, qWidth, qHeight]).then (answers) ->
    answers.format = getFormat(answers.format)
    answers.libraries.unshift uri.screenad

    writeFile path, answers, (writeErr) ->
      throw writeErr if writeErr?
      console.log "Settings saved to '#{path}'. You can always edit the find manually or run this script again to start over.\n"
