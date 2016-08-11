'use strict'

{load} = require('cheerio')
request = require('request-promise-native')

options = method: 'POST'


class HTTP
  constructor: ->
    return

  get: (uri) ->
    transform = (body) -> load(body)
    return request({uri, transform})

  post: (url, form, formData={}) ->
    return request(Object.assign options, {uri, form})

  upload: (url, formData) ->
    return request(Object.assign options, {uri, formData})


module.exports = new HTTP()
