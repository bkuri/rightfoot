'use strict'

{expect} = require('chai')
{ls} = require('shelljs')


module.exports =
  find: (base, what) ->
    found = ls("#{ base }/#{ what }").length
    return expect(found).not.to.equal(0)

  valid: (dir) ->
    match = (file) -> file.match(/[^A-Za-z0-9\.\,\/]/g)
    found = ls('-R', dir).filter(match).length
    return expect(found).to.equal(0)
