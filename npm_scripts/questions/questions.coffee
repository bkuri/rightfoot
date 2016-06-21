'use strict'


{load} = require('cheerio')
request = require('request')


PLAIN = 'Standard HTML5'
URI = 'http://developer.weborama.nl/tools-downloads/'

class WizardQuestions
  # firstRound: => [@qName, @qLang, @qType, @qImage]
  firstRound: => [@qName, @qLang, @qType]
  # nextRound: => [@qWidth, @qHeight, @qSticky, @qOffset, @qZIndex, @qLibs]
  nextRound: => [@qWidth, @qHeight, @qSticky, @qZIndex, @qLibs]

  _nonEmpty: (what) ->
    String(what).trim().length > 0

  _onlyNumbers: (what) ->
    Number(what) or what

  qName:
    message: 'Give this project a name:'
    name: 'name'
    validate: @_nonEmpty

  qLang:
    default: 'en'
    message: 'Which language would you like to use?'
    name: 'lang'
    validate: @_nonEmpty

  qType:
    choices: [PLAIN]
    default: 0
    message: 'Banner type:'
    name: 'type'
    type: 'rawlist'

  qWidth:
    default: 320
    filter: @_onlyNumbers
    message: 'Width:'
    name: 'width'
    validate: @_nonEmpty

  qHeight:
    default: 240
    filter: @_onlyNumbers
    message: 'Height:'
    name: 'height'
    validate: @_nonEmpty

  qLibs:
    choices: []
    message: 'Select the libraries that you would like to use:'
    name: 'libraries'
    type: 'checkbox'

  qSticky:
    default: yes
    message: 'Sticky?'
    name: 'sticky'
    type: 'confirm'

  qZIndex:
    default: 1
    filter: @_onlyNumbers
    message: 'Z-Index'
    name: 'zindex'
    validate: (what) -> Number(what) and (Number(what) > 0)

  constructor: ->
    libs = []

    request uri: URI, (err, resp, body) =>
      throw err if err?
      $ = load(body)

      $('tr', '#content').each (index, item) ->
        return if (index is 0)
        name = ''

        $('td', item).each (i) ->
          value = $(@).text().trim()

          switch
            when (i is 0) then name += "#{value} v"
            when (i is 1) then name += value
            else libs.push {name, value}

      @qLibs.choices = libs

    return


module.exports = WizardQuestions
