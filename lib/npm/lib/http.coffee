'use strict'

{load} = require('cheerio')
request = require('request-promise-native')

method = 'POST'


class HTTP
  constructor: ->
    return

  get: (uri) ->
    transform = (body) -> load(body)
    return request({uri, transform})

  post: (url, form, formData={}) ->
    return request({method, uri, form})

  upload: (url, formData) ->
    return request({method, uri, formData})


module.exports = new HTTP()
