#!/bin/env coffee
'use strict'


{load} = require('cheerio')
{prompt} = require('inquirer')
request = require('request')
uri = 'http://developer.weborama.nl/tools-downloads/'


qLibs =
  choices: []
  message: 'Select the libraries that you would like to use:'
  name: 'libraries'
  type: 'checkbox'
  when: (answers) -> answers.scratch


request {uri}, (err, resp, body) ->
  throw err if err?
  $ = load(body)

  $('tr', '#content').each (index, item) ->
    return if (index is 0)
    name = ''

    $('td', item).each (i) ->
      t = $(@).text().trim()

      switch
        when (i is 0) then name += "#{t} v"
        when (i is 1) then name += t
        else libs.choices.push Object.assign {name}, value: t

  prompt([qLibs]).then (answers) ->
    console.log JSON.stringify(answers, null, '  ')
