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
      when 'backup'
        "Code #{ extra } while attempting backup. Scrub operation aborted."

      when 'load'
        "Code #{ extra } while restoring saved project."

      when 'nopub'
        'There are no files left to delete in the public folder.'

      when 'novars'
        'There is no settings file yet. Try running the wizard first.'

      when 'scrub'
        "Code #{ extra } while attempting scrub operation. Loading aborted."

      else
        extra

    console.error red("\n× ERROR: #{ message }\n")
    exit 1
    return


  info: (key, extra=null) ->
    console.log switch key
      when 'clean'
        cyan '\n· Cleaning public folder…\n'

      when 'copied'
        green "→ Copied #{ extra }"

      when 'build', 'snapshot'
        cyan "\n· Compiling #{ extra } version…\n"

      when 'img'
        cyan '· Generating backup images…'

      when 'load'
        cyan("\n· Loading project '#{ extra }'…") if extra?

      when 'saved'
        green "→ Saved file '#{ extra }'"

      when 'scrub'
        cyan '\n· Scrubbing active project…'

      when 'scrubbed'
        green '→ Finished. Run "npm start" again to start a new project.\n'

      when 'server'
        cyan '\n· Starting server on http://localhost:3333 (Use Ctrl+C to close)\n'

      when 'standard'
        cyan '\n· Building standard development version…'

      when 'subtitle'
        yellow "\n· #{ extra } settings".toUpperCase()

      when 'title'
        yellow "\n  WEBORAMA TEMPLATE STUDIO v#{ extra }\n"

      when 'writevars'
        green "→ Settings file '#{ extra }' saved.\n"

      when 'zipped'
        green "\n· Zip file saved as public/#{ extra }.zip\n"

      else ''

    return


  warning: (message) ->
    console.log yellow("\nWARNING: #{ message }\n")
    return


  constructor: ->
    return


module.exports = new Messages()
