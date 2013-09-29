
#
# * GET home page.
# 
Utils = require('./utils').Utils

exports.index = (req, res) ->
  res.render "index", Utils.pageInfo(req)

