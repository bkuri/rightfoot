'use strict'


init_banner = ->
  # screenad.onPreloadComplete = onPreloadComplete
  screenad.setAlignment 'banner', 'banner'
  screenad.setSize banner.width, banner.height
  screenad.setOffset banner.offset.x, banner.offset.y
  screenad.setSticky banner.sticky
  screenad.setZIndex banner.zindex
  screenad.position()
  return
