# utils
_ =  require('underscore')
crypto = require 'crypto'

exports.Utils = 
  checkParams: (params, defines) ->
    _keys = _.keys params
    _ret = true
    _.each defines, (d) ->
      unless _.contains _keys, d
        _ret = false
    _ret
  getCrypto: (d) ->
    #fixme 
    d
  pageInfo: (req) ->
    conf =
      title: "Meriazard"
      url: (req.route.path).replace('/', '')
    conf
  dateFormat: (o) ->
    "test"
