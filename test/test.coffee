'use strict'

{find, valid} = require('./lib/filesystem')
{readFileSync} = require('fs-cson')


describe 'Filesystem tests (app dir)', ->
  found = (what) -> find('app', what)

  it 'should find the settings file', ->
    found 'variables.cson'

  it 'should find at least one marko file', ->
    found 'assets/*.marko'

  it 'should find at least one stylus file', ->
    found '*.styl'

  it 'should NOT find foreign characters in filenames', ->
    valid 'app'


describe 'Filesystem tests (public dir)', ->
  found = (what) -> find('public', what)
  piece = readFileSync('app/variables.cson')

  it 'should find at least one html file', ->
    found '*.html'

  it 'should find at least one css file', ->
    found '*.css'

  it 'should find a backup image file', ->
    found 'backup.*'

  it 'should find a backup gif file', ->
    {width, height} = piece.banner
    found "#{ width }x#{ height }.gif"

  it 'should NOT find foreign characters in filenames', ->
    valid 'public'
