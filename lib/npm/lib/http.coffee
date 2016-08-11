'use strict'

{load} = require('cheerio')
request = require('request-promise')


class HTTP
  constructor: ->
    return

  get: (uri) ->
    transform = (body) -> load(body)
    return request(build {transform, uri})

  post: (url, form, formData={}) ->
    options = method: 'POST'
    return request(Object.assign options, {uri, form})

  upload: (url, formData) ->
    options = method: 'POST'
    return request(Object.assign options, {uri, formData})

module.exports = new HTTP()
