
#
# * GET users listing.
# 
models = require('../models/models')
Utils = require('./utils').Utils
User = models.User

LOGIN_KEYS = ["input_id", "input_passwd"]

# login
exports.login = (req, res) ->
  _params = req.body || {}
  unless Utils.checkParams(_params, LOGIN_KEYS)
    res.redirect('/');
  # user を select
  User.find
    user_id: _params.input_id
  , (err, docs) ->
    if docs.length == 1
      user = docs[0]
      # password をチェック
      dbPass = Utils.getCrypto(user.passwd)
      queryPass = Utils.getCrypto(_params.input_passwd)
      if dbPass == queryPass
        res.redirect('/list');
        return
    res.redirect('/')

# 一覧表示 初期表示
exports.list = (req, res) ->
  # fixme session check
  res.render "list", Utils.pageInfo(req)

# 一覧表示 読み込み
exports.search = (req, res) ->
  res.contentType('application/json');
  # fixme session check

  # test data
  _data = [
    {
      no: 1
      filename: 'test_file.zip'
      size: 100
      created: new Date
    }
    {
      no: 2
      filename: 'test_file2.zip'
      size: 100
      created: new Date
    }
    {
      no: 3
      filename: 'test_file3.zip'
      size: 100
      created: new Date
    }
  ]

  res.send _data

