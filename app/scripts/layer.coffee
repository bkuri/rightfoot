'use strict'


init_layer = ->
  # screenad.onPreloadComplete = onPreloadComplete
  screenad.hide 'self'
  screenad.setSize layer.width, layer.height
  screenad.setAlignment 'banner', 'banner'
  screenad.setOffset layer.offset.x, layer.offset.y
  screenad.setSticky layer.sticky
  screenad.setZIndex layer.zindex
  screenad.position()
  return
