'use strict'

{cp, exec, find, mkdir, test} = require('shelljs')
{readFileSync, writeFile} = require('fs-cson')
Messages = require('./messages')

VARS = 'app/variables.cson'


class Tools
  clear: ->
    process.stdout.write '\u001B[2J\u001B[0;0f'
    return


  copy: (what, condition=yes, rename=null) =>
    return @ unless condition
    ext = what.match(/[^\.]+$/)[0]

    where = switch ext
      when 'coffee' then 'app/scripts'
      when 'styl' then 'app/styles'
      else 'app/assets'

    mkdir '-p', where
    where = "#{ where }/#{ rename }.#{ ext }" if rename?

    cp what, where
    @msg.info 'copied', what
    return @


  copyFolder: (what) =>
    files = find("#{ what }/*")
      .stdout.split '\n'
      .filter (line) -> line.length

    @copy file for file in files
    return @


  foundVars: ->
    return test('-f', VARS)


  readVars: =>
    @msg.error('novars') unless @foundVars()
    return readFileSync(VARS)


  run: (command, after=null) =>
    @msg.info command

    exec "npm run #{ command }", (code, stdout, stderr) =>
      # @msg.error(command, stderr) if stderr?
      # @msg.info(command, stdout) if stdout?
      @msg.info(after) if after?
      return

    return


  writeVars: (data) =>
    mkdir '-p', 'app'

    writeFile VARS, data, (error) =>
      throw error if error?
      @msg.info 'writevars', VARS
      return

    return @


  constructor: ->
    @msg = new Messages()
    return


module.exports = Tools
