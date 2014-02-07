
#
# * GET users listing.
# 
fs = require('fs')
mongoose = require('mongoose')
_ = require('underscore')

models = require('../models/models')
Utils = require('./utils').Utils
User = models.User
Doc = models.Doc

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
  _data = []
  _i = 0
  Doc.find {}, (err, docs) ->
    _.each docs, (d) ->
      _i += 1
      _data.push 
        no: _i
        doc_id: d._id
        filename: d.name
        size: d.size
        content_type: if d.file.content_type then d.file.content_type else ""
        created: Utils.dateFormat( d.create_at )
    res.send _data

# file を登録します
exports.upload = (req, res) ->
  # fixme マルチ読み込み
  # fixme HTML5 File API を使u
  file = req.files.register_input
  doc = new Doc
  doc.name = encodeUriComponent file.name
  doc.size = file.size
  doc.file = 
    data: fs.readFileSync(file.path)
    content_type: file.headers["content-type"]
  doc.create_at = new Date
  doc.save (e) ->
    console.log 'error' + e if e
    res.render 'async_load'

# file を download します．
exports.download = (req, res) ->
  _id = req.params.doc_id
  Doc.find {_id: _id}, (err, docs) ->
    if err
      res.send ""
    else
      _file = docs[0]
      res.setHeader('Content-disposition', 'attachment; filename=' + _file.name )
      res.setHeader('Content-type', _file.file.content_type);
      res.setHeader('Content-Length', _file.size);
      res.write(_file.file.data, 'binary')
      res.end()



