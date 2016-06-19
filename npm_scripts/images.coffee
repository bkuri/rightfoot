#!/usr/bin/env coffee
'use strict'


chroma = require('chroma-js')
data = require('fs-cson').readFileSync('app/variables.cson')
gm = require('gm')

defaults = border: 2, color: '#fff', gravity: 'Center', quality: 85, source: 'logo1'
img = Object.assign(defaults, data.image)


callback = (err) ->
  throw err if err?


invert = (color) ->
  channels = chroma(color).rgb()
  channels[i] = (if i is 3 then 1 else 255) - c for c, i in channels
  return "rgb(#{ channels.join(',') })"


backup = (size = data, dest = '') ->
  s = (img.border * 2)

  gm("app/assets/logos/#{ img.source }.png")
    .background img.color
    .gravity img.gravity
    .extent (size.width - s), (size.height - s)
    .borderColor invert(img.color)
    .border img.border, img.border
    .quality img.quality
    .write "public/backup#{ dest }.jpg", callback

  return


blank = ->
  b = '#000'
  {width, height} = data

  gm(width, height, b)
    .transparent b
    .write "public/#{ width }x#{ height }.gif", callback

  return


backup()
backup(data.expanded, '-layer') if data.expanded?
blank()
