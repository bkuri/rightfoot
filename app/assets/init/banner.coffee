'use strict'


init_banner = ->
  # screenad.onPreloadComplete = onPreloadComplete
  screenad.setAlignment 'banner', 'banner'
  screenad.setSticky banner.sticky
  screenad.setSize banner.width, banner.height
  screenad.setOffset banner.x, banner.y
  screenad.setZIndex banner.z
  screenad.position()
  return
