'use strict'

{concat} = require('lodash')
{load} = require('cheerio')
request = require('request')
{Separator} = require('inquirer')

PLAIN = 'Standard HTML5'
URI = 'http://developer.weborama.nl/tools-downloads/'

class WizardQuestions
  # firstRound: => [@qName, @qLang, @qType, @qImage]
  firstRound: (choices) =>
    @qType.choices = concat([PLAIN], choices)
    return [@qName, @qLang, @qType]

  menu: =>
    [@qMenu]

  nextRound: =>
    [@qWidth, @qHeight, @qSticky, @qOffsetX, @qOffsetY, @qZIndex, @qLibs]

  qMenu:
    choices: [
      {name: 'Start a live development server at http://localhost:3333', value: 'server'}
      new Separator()
      {name: 'Create & zip a snapshot of the current template as is', value: 'current'}
      {name: 'Create & zip a production version of the current template', value: 'production'}
      new Separator()
      {name: 'Clean up public folder (leave everything else intact)', value: 'public'}
      {name: 'Clean up everything and start a new project', value: 'restart'}
      new Separator()
      {name: 'Just exit', value: 'exit'}
    ]
    message: 'What would you like to do now?'
    name: 'choice'
    type: 'list'

  qLibs:
    choices: []
    message: 'Select the libraries that you would like to use:'
    name: 'libraries'
    type: 'checkbox'

  qType:
    choices: []
    default: 0
    message: 'Banner type:'
    name: 'type'
    type: 'list'

  qSticky:
    default: yes
    message: 'Sticky?'
    name: 'sticky'
    type: 'confirm'

  constructor: ->
    libs = []

    createNumericInput = (name, def=0, min=def) ->
      n = name.split(' ')[0].toLowerCase()

      default: def
      filter: (val) -> Number(val)
      message: "#{name}:"
      name: n

      validate: (val) ->
        return no if Number.isNaN(val)
        return no if (Number(val) < min) and (n isnt 'x') and (n isnt 'y')
        return yes

    createTextInput = (name, message, def=null) ->
      Object.assign {name, message},
        default: def
        filter: (val) -> String(val).trim()
        validate: (val) -> (String(val).trim().length > 0)

    @qName = createTextInput('name', 'Give this project a name:')
    @qLang = createTextInput('lang', 'What language will the banner be in?', 'en')
    @qWidth = createNumericInput('Width', 320, 1)
    @qHeight = createNumericInput('Height', 240, 1)
    @qOffsetX = createNumericInput('X Offset')
    @qOffsetY = createNumericInput('Y Offset')
    @qZIndex = createNumericInput('Z Index', 1)

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
