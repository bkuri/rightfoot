'use strict'

{load} = require('cheerio')
request = require('request')

PLAIN = 'Standard HTML5'
URI = 'http://developer.weborama.nl/tools-downloads/'

class WizardQuestions
  # firstRound: => [@qName, @qLang, @qType, @qImage]
  firstRound: => [@qName, @qLang, @qType]
  nextRound: => [@qWidth, @qHeight, @qSticky, @qOffsetX, @qOffsetY, @qZIndex, @qLibs]

  _nonEmpty: (what) ->
    String(what).trim().length > 0

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

  qWidth: {}
  qHeight: {}
  qOffsetX: {}
  qOffsetY: {}
  qZIndex: {}

  constructor: ->
    libs = []

    create = (name, def=0, min=def) ->
      name: name.split(' ')[0].toLowerCase()
      default: def
      message: "#{name}:"
      validate: (val) -> !Number.isNaN(val) and Number(val) >= min
      filter: (val) -> Number(val)

    @qWidth = create('Width', 320, 1)
    @qHeight = create('Height', 240, 1)
    @qOffsetX = create('X Offset')
    @qOffsetY = create('Y Offset')
    @qZIndex = create('Z Index', 1)

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
