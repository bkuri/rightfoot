'use strict'

{concat} = require('lodash')
{cp, exec, rm} = require('shelljs')
{readdir, readdirSync, rename, statSync} = require('fs')
{readFile, writeFile} = require('fs-cson')
{zip} = require('bauer-zip')
Messages = require('./messages')

VARS = 'app/variables.cson'

class UtilityBelt
  constructor: ->
    @msg = new Messages()


  cleanUp: (everything=no, dryRun=no) =>
    targets = ['public']

    if everything
      concat targets, ['app/assets', 'app/partials', 'app/scripts', 'app/styles']
      if @foundVars() then rm('-f', VARS)

    for target in targets
      readdir target, (readError, files) =>
        throw readError if readError?

        for file in files
          path = "#{ target }/#{ file }"
          continue unless statSync(path).isFile()

          unless dryRun then rm('-f', path)
          else @msg.info('drydel', path)

    return


  copyFiles: (files, to='app/assets', from='app/assets/init') =>
    for file in files
      path = "#{ to }/#{ file }"
      cp "#{ from }/#{ file }", path
      @msg.info 'copied', path

    return


  foundVars: ->
    found = no

    try
      statSync VARS
      found = yes

    catch error
      found = no

    return found


  startServer: =>
    @msg.info 'server'

    exec '/usr/bin/brunch watch --server', (code, stdout, stderr) =>
      @msg.error('server', stderr) if stderr?
      @msg.debug('server', stdout) if stdout?

    return


  writeVars: (data) =>
    writeFile VARS, data, (error) =>
      throw error if error?
      @msg.info 'writevars', VARS


  zip: =>
    old = './public'

    return @msg.error('nopub') if (readdirSync(old).length < 1)

    readFile 'app/variables.cson', (readErr, data) =>
      throw readErr if readErr?
      name = "#{ data.name }-#{ data.width }x#{ data.height }"

      rename old, name, (renameErr) =>
        throw renameErr if renameErr?

        zip name, "#{ name }/#{ name }.zip", (zipErr) =>
          throw zipErr if zipErr?

          @msg.info 'zipped', name
          rename "./#{ name }", old

    return

module.exports = UtilityBelt
