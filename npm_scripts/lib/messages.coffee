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

    console.error red("\n× ERROR: #{ message }\n")
    exit 1
    return


  info: (key, extra='') ->
    message = switch key
      when 'clean'
        '\n· Cleaning public folder…\n'

      when 'copied'
        "→ Copied #{ extra }"

      when 'deploy', 'snapshot'
        "\n· Compiling #{ extra } version…\n"

      when 'img'
        '· Generating backup images…'

      when 'saved'
        "· Saved file '#{ extra }'"

      when 'scrub'
        '\n· Restoring original state…'

      when 'scrubbed'
        'Finished. Run "npm start" again to start a new project.\n'

      when 'server'
        '\n· Starting server on http://localhost:3333 (Use Ctrl+C to close)\n'

      when 'standard'
        '\n· Building standard development version…\n'

      when 'subtitle'
        "\n· #{ extra } settings".toUpperCase()

      when 'title'
        "\nWEBORAMA TEMPLATE STUDIO v#{ extra }\n"

      when 'writevars'
        "→ Settings file '#{ extra }' saved.\n"

      when 'zipped'
        "\n· Zip file saved as public/#{ extra }.zip\n"

    console.log green(message)
    return


  warning: (message) ->
    console.log yellow("\nWARNING: #{ message }\n")
    return


  constructor: ->
    return


module.exports = Messages
