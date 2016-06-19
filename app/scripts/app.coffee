'use strict'


PATTERN = /^SCR(.*):\s(.*)$/
data = {}


# populate data with values in comment tags
for node in document.childNodes
  for n in node.childNodes when (n.nodeType is document.COMMENT_NODE)
    match = n.nodeValue.match(PATTERN)
    data[match[1].toLowerCase()] = match[2] if match?


# called when document is loaded
init = ->
  screenad.setAlignment data.format, data.format
  screenad.setSize data.width, data.height
  screenad.setSticky yes
  screenad.setZIndex 1
  screenad.setOffset 0, 0
  screenad.position()
  return
