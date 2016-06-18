#!/usr/bin/env coffee
'use strict'


chroma = require('chroma-js')
data = require('fs-cson').readFileSync('app/variables.cson')
gm = require('gm')

defaults = border: 2, color: '#fff', gravity: 'Center', quality: 85, source: 'logo1'
img = Object.assign(defaults, data.image)


invert = (color) ->
  channels = chroma(color).rgb()
  channels[i] = (if i is 3 then 1 else 255) - c for c, i in channels
  return "rgb(#{ channels.join(',') })"


make = (size, dest = '') ->
  s = (img.border * 2)

  gm("app/assets/logos/#{img.source}.png")
    .background img.color
    .gravity img.gravity
    .extent (size.width - s), (size.height - s)
    .borderColor invert(img.color)
    .border img.border, img.border
    .quality img.quality

    .write "public/backup#{dest}.jpg", (err) ->
      throw err if err?

  return


make(data.expanded, '-layer') if data.expanded?
make data
