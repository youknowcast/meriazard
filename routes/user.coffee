
#
# * GET users listing.
# 
models = require('../models/models')
User = models.User

# login
exports.login = (req, res) ->
  _params = req.query || {}
  # パラメータ不正であれば，top へ戻す．
  unless _params.user_id? || _params.user_passwd?
    res.redirect('/');

