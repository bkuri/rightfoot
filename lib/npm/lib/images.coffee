'use strict'

chroma = require('chroma-js')
gm = require('gm')


class Images
  backup: (what, suffix = '') =>
    {image} = @data
    name = "public/backup#{ suffix }.jpg"
    s = (image.border * 2)

    gm("lib/logos/#{ image.source }.png")
      .background image.color
      .gravity image.gravity
      .extent (@data[what].width - s), (@data[what].height - s)
      .borderColor @invert(image.color)
      .border image.border, image.border
      .quality image.quality
      .write name, @callback(name)

    return

  blank: =>
    b = '#000'
    {width, height} = @data['banner']
    name = "public/#{ width }x#{ height }.gif"

    gm(width, height, b)
      .transparent b
      .write name, @callback(name)

    return

  invert: (color) ->
    channels = chroma(color).rgb()
    channels[i] = (if i is 3 then 1 else 255) - c for c, i in channels
    return "rgb(#{ channels.join(',') })"

  constructor: (@data, @callback) ->
    return


module.exports = Images
