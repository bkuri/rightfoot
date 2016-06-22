'use strict'

{green, red, yellow} = require('chalk')

class Messages
  debug: (key, extra='') ->
    return unless @debugging

    message = switch(key)
      when 'del' then "deleted '#{ extra }'"
      else extra

    console.debug cyan(message)
    return

  error: (key, extra) ->
    message = switch key
      when 'nopub' then 'There are no files in the public folder. Try running "npm run build" first.'
      when 'novars' then 'There is no settings file yet. Try running the wizard first.'
      else extra

    console.error red("\nERROR: #{ message }\n")
    return

  info: (key, extra='') ->
    message = switch key
      when 'copied' then "copied #{ extra }"
      when 'drydel' then "would have deleted #{ extra }"
      when 'saved' then "saved file '#{ extra }'"
      when 'server' then '\nstarting server on http://localhost:3333\n'
      when 'subtitle' then "\n#{ extra } settings".toUpperCase()
      when 'title' then "\nWEBORAMA TEMPLATE STUDIO v#{ extra }\n"
      when 'writevars' then "\nSettings saved to '#{ extra }'. You can always edit the file manually or run this wizard again to start over."
      when 'zipped' then "\nZip file saved as public/#{ extra }.zip"

    console.log green(message)
    return

  warning: (key) ->
    console.log yellow("\nWARNING: #{ message }\n")
    return

  constructor: (@debugging=no) ->

module.exports = Messages
