'use strict'


{load} = require('cheerio')
{Separator} = require('inquirer')
request = require('request-promise')

PLAIN = 'Standard HTML5'
URI = 'http://developer.weborama.nl/tools-downloads/'


class Questions
  confirm: (message) ->
    return Object.assign {message},
      defaut: no
      name: 'confirmed'
      type: 'confirm'


  firstStage: (choices) =>
    @qType.choices = choices
    # return [@qName, @qLang, @qType, @qImage]
    return [@qName, @qLang, @qType]


  menu: =>
    return [@qMenu, @qScrub]


  nextStage: =>
    return [@qWidth, @qHeight, @qSticky, @qOffsetX, @qOffsetY, @qZIndex, @qLibs]


  qLibs:
    choices: []
    message: 'Select the libraries that you would like to use:'
    name: 'libraries'
    type: 'checkbox'


  qMenu:
    choices: [
      {name: 'Start a live development server at http://localhost:3333', value: 'server'}
      {name: 'Render the current state to the public folder', value: 'standard'}
      new Separator()
      {name: 'Zip production version of the current state', value: 'deploy'}
      {name: 'Zip snapshot of the current state (as is)', value: 'snapshot'}
      new Separator()
      {name: 'Clean up public folder (leave everything else intact)', value: 'clean'}
      {name: 'Start a new project from scratch', value: 'scrub'}
      new Separator()
      {name: 'Exit and do nothing', value: 'exit'}
    ]
    message: 'What would you like to do?'
    name: 'choice'
    type: 'list'


  qScrub:
    defaut: no
    message: 'Are you sure? You will lose all your current work!'
    name: 'confirm'
    type: 'confirm'
    when: (answers) -> (answers.choice is 'scrub')


  qSticky:
    default: yes
    message: 'Sticky?'
    name: 'sticky'
    type: 'confirm'


  qType:
    choices: []
    default: 0
    message: 'Banner type:'
    name: 'type'
    type: 'list'


  constructor: ->
    inputNumber = (name, def=0, min=def) ->
      name = name.split(' ')[0].toLowerCase()

      return Object.assign {name},
        default: def
        filter: (val) -> Number(val)
        message: "#{ name }:"

        validate: (val) ->
          return no if Number.isNaN(val)
          return no if (Number(val) < min) and (name isnt 'x') and (name isnt 'y')
          return yes

    inputText = (name, message, def=null) ->
      return Object.assign {name, message},
        default: def
        filter: (val) -> String(val).trim()
        validate: (val) -> (String(val).trim().length > 0)

    libs = []

    options =
      uri: URI
      transform: (body) -> load(body)

    request(options)
      .then ($) ->
        $('tr', '#content').each (index, item) ->
          return if (index is 0)
          name = ''

          $('td', item).each (i) ->
            value = $(@).text().trim()

            switch
              when (i is 0) then name += "#{ value } v"
              when (i is 1) then name += value
              else libs.push {name, value}

            return

          return

        return

      .catch (error) ->
        # @msg.error 'http', error
        throw error

      .finally =>
        @qLibs.choices = libs
        return

    @qHeight = inputNumber('Height', 240, 1)
    @qLang = inputText('lang', 'What language will the banner be in?', 'en')
    @qName = inputText('name', 'Please give this project a name:')
    @qOffsetX = inputNumber('X Offset')
    @qOffsetY = inputNumber('Y Offset')
    @qWidth = inputNumber('Width', 320, 1)
    @qZIndex = inputNumber('Z Index', 1)
    return


module.exports = Questions
