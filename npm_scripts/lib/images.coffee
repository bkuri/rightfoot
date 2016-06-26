'use strict'


chroma = require('chroma-js')
gm = require('gm')
Messages = require('./messages')


class Images
  backup: (what, suffix = '') =>
    {image} = @data
    name = "public/backup#{ suffix }.jpg"
    s = (image.border * 2)

    gm("app/assets/logos/#{ image.source }.png")
      .background image.color
      .gravity image.gravity
      .extent (@data[what].width - s), (@data[what].height - s)
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
    {width, height} = @data['banner']
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

  constructor: (@data) ->
    @msg = new Messages()
    return


module.exports = Images
