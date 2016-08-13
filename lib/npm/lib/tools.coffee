'use strict'

{cp, exec, find, mkdir, test} = require('shelljs')
#{createReadStream} = require('fs')
#{post, upload} = require('./http')
{readFileSync, writeFile} = require('fs-cson')
msg = require('./messages')

SETTINGS = './settings.cson'
#URI_ADD = 'http://clients.weborama.nl/previewer/addcampaign'
#URI_LOGIN = 'http://clients.weborama.nl/login'
#URI_UPLOAD = 'http://clients.weborama.nl/previewer/upload'
VARS = 'app/variables.cson'


class Tools
  clear: ->
    process.stdout.write '\u001B[2J\u001B[0;0f'
    return


  copy: (what, condition=yes, rename=null) =>
    return @ unless condition
    ext = what.match(/[^\.]+$/)[0]

    where = switch ext
      when 'coffee', 'styl' then 'app'
      else 'app/assets'

    mkdir '-p', where
    where = "#{ where }/#{ rename }.#{ ext }" if rename?

    cp what, where
    msg.info 'copied', what
    return @


  copyFolder: (what) =>
    files = find("#{ what }/*")
      .stdout.split '\n'
      .filter (line) -> line.length

    @copy file for file in files
    return @


  foundFile: (what=VARS) ->
    return test('-f', what)


  load: (what, backup) =>
    restore = (what) =>
      msg.info 'load', what

      @run 'scrub', (code) ->
        msg.error('scrub') unless (code is 0)

        exec "rsync -avh saved/#{ what }/ app/", (code, stdout, stderr) ->
          msg.error('load', code) unless (code is 0)
          return

        return

      return

    if backup
      exec 'npm run backup', (code, stdout, stderr) ->
        if (code is 0) then restore(what)
        else msg.error('restore', code)
        return

    else restore(what)
    return


  # TODO: finish this up
  ###
  preview: =>
    data = @readVars()
    extra = '5583472657/129762'
    name = "public/#{ data.meta.name }.zip"
    settings = readFileSync(SETTINGS)

    steps = [
      post(URI_LOGIN, settings.previewer)
      post(URI_ADD, inputCampaignName: 'testing-1-2-3')
      post("#{ URI_UPLOAD }/#{ extra }", uploadFile_1: createReadStream(name) )
    ]

    Promise.all(steps)
      .catch (error) ->
        throw error

      .then (body) ->
        return

    return
  ###


  readVars: =>
    msg.error('novars') unless @foundFile()
    return readFileSync(VARS)


  run: (command, after=null) ->
    msg.info command

    exec "npm run #{ command }", (code, stdout, stderr) ->
      return unless after?

      if (typeof after is 'function') then after(code)
      else msg.info(after)
      return

    return


  scrub: (backup) =>
    if backup
      exec 'npm run backup', (code, stdout, stderr) =>
        if (code is 0) then @run('scrub')
        else msg.error('backup', code)
        return

    else @run('scrub')
    return


  writeVars: (data) =>
    mkdir '-p', 'app'

    writeFile VARS, data, (error) ->
      throw error if error?
      msg.info 'writevars', VARS
      return

    return @


  constructor: ->
    return


module.exports = new Tools()
