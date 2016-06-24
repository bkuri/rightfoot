'use strict'


chroma = require('chroma-js')
gm = require('gm')
Messages = require('./lib/messages')


class Imager
  backup: (size = @data, dest = '') =>
    {image} = @data
    name = "public/backup#{ dest }.jpg"
    s = (image.border * 2)

    gm("app/assets/logos/#{ image.source }.png")
      .background image.color
      .gravity image.gravity
      .extent (size.width - s), (size.height - s)
      .borderColor @invert(image.color)
      .border image.border, image.border
      .quality image.quality

      .write name, (err) =>
        throw err if err?
        @msg.info 'saved', name
        return

    return

  blank: =>
    b = '#000'
    {width, height} = @data
    name = "public/#{ width }x#{ height }.gif"

    gm(width, height, b)
      .transparent b

      .write name, (err) =>
        throw err if err?
        @msg.info 'saved', name
        return

    return

  invert: (color) ->
    channels = chroma(color).rgb()
    channels[i] = (if i is 3 then 1 else 255) - c for c, i in channels
    return "rgb(#{ channels.join(',') })"

  constructor: ->
    @msg = new Messages()
    return


module.exports = Imager
