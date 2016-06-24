'use strict'


{cp, exec, exit, mkdir, mv, rm, test} = require('shelljs')
{readFileSync, writeFile} = require('fs-cson')
Messages = require('./messages')

VARS = 'app/variables.cson'


class Tools
  clear: ->
    process.stdout.write '\u001B[2J\u001B[0;0f'
    return


  copy: (what, where=null) =>
    ext = what.match(/\.(.*)$/)[1]

    unless where? then where = switch ext
      when 'coffee' then 'scripts'
      when 'styl' then 'styles'
      else 'assets'

    dest = "app/#{ where }"

    mkdir '-p', dest
    cp "app/assets/init/#{ what }", dest
    @msg.info 'copied', what
    return


  copyFolder: (what) =>
    cp "app/assets/templates/#{ what }/*", 'app/assets'
    @msg.info 'copied', "#{ what } template files."
    return


  foundVars: ->
    return test('-f', VARS)


  readVars: =>
    @msg.error('novars') unless @foundVars()
    return readFileSync(VARS)


  run: (command, after=null) =>
    @msg.info command

    exec "npm run #{ command }", (code, stdout, stderr) =>
      @msg.debug(command, stdout) if stdout?
      @msg.error(command, stderr) if stderr?
      @msg.info(after) if after?
      return

    return


  writeVars: (data) =>
    writeFile VARS, data, (error) =>
      throw error if error?
      @msg.info 'writevars', VARS
      return

    return


  constructor: ->
    @msg = new Messages()
    return


module.exports = Tools
