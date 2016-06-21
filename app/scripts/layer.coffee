'use strict'


init_layer = ->
  # screenad.onPreloadComplete = onPreloadComplete
  screenad.hide 'self'
  screenad.setAlignment 'banner', 'banner'
  screenad.setSticky layer.sticky
  screenad.setSize layer.width, layer.height
  screenad.setOffset layer.x, layer.y
  screenad.setZIndex layer.z
  screenad.position()
  return
