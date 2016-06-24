'use strict'


{cyan, green, red, yellow} = require('chalk')
{exit} = require('shelljs')


class Messages
  debug: (key, extra='') ->
    message = switch(key)
      when 'del' then "→ Deleted file '#{ extra }'."
      else extra

    console.log cyan(message)
    return


  error: (key, extra) ->
    message = switch key
      when 'nopub'
        'There are no files left to delete in the public folder.'

      when 'novars'
        'There is no settings file yet. Try running the wizard first.'

      else
        extra

    console.error red("\nERROR: #{ message }\n")
    exit 1
    return


  info: (key, extra='') ->
    message = switch key
      when 'clean'
        '\nCleaning public folder...\n'

      when 'copied'
        "→ Copied #{ extra }"

      when 'deploy', 'snapshot'
        "\nCompiling #{ extra } version...\n"

      when 'saved'
        "→ Saved file '#{ extra }'"

      when 'scrub'
        '\nRestoring original state...'

      when 'scrubbed'
        'Finished. Run "npm start" again to start a new project.\n'

      when 'server'
        '\nStarting server on http://localhost:3333\n'

      when 'standard'
        '\nBuilding standard development version...\n'

      when 'subtitle'
        "\n#{ extra } settings".toUpperCase()

      when 'title'
        "\nWEBORAMA TEMPLATE STUDIO v#{ extra }\n"

      when 'writevars'
        "→ Settings file '#{ extra }' saved.\n"

      when 'zipped'
        "\nZip file saved as public/#{ extra }.zip\n"

    console.log green(message)
    return


  warning: (message) ->
    console.log yellow("\nWARNING: #{ message }\n")
    return


  constructor: ->
    return


module.exports = Messages
