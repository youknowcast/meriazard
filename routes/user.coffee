
#
# * GET users listing.
# 
fs = require('fs')
mongoose = require('mongoose')
_ = require('underscore')
crypto = require('crypto')

models = require('../models/models')
Utils = require('./utils').Utils
User = models.User
Doc = models.Doc

LOGIN_KEYS = ["input_id", "input_passwd"]
FILE_PREFIX = './files/F_'

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
  res.contentType('application/json')
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
        content_type: d.content_type
        created: Utils.dateFormat( d.create_at )
    res.send _data

exports.searchQuery = (req, res) ->
  res.contentType('application/json')
  _query = {name: req.params.query}
  _data = []
  _i = 0
  Doc.find _query, (err, docs) ->
    _.each docs, (d) ->
      _i += 1
      _data.push 
        no: _i
        doc_id: d._id
        filename: d.name
        size: d.size
        content_type: d.content_type
        created: Utils.dateFormat( d.create_at )
    res.send _data

checksum = (str) ->
  crypto.createHash('md5').update(str, 'binary').digest('hex')


# file を登録します
exports.upload = (req, res) ->
  file = req.files.register_input
  filePath = FILE_PREFIX + checksum(fs.readFileSync(file.path))
  # path 名で保存
  fs.rename(file.path, filePath, (err) ->
    throw err
  )
  doc = new Doc
  doc.name = file.name
  doc.size = file.size
  doc.path = filePath
  doc.content_type = file.headers["content-type"]
  doc.create_at = new Date doc.save (e) ->
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
      res.setHeader('Content-disposition', 'attachment; filename*=UTF-8\'\'' + encodeURIComponent(_file.name) )
      res.setHeader('Content-type', _file.content_type);
      res.setHeader('Content-Length', _file.size);
      res.write(fs.readFileSync(_file.path), 'binary')
      res.end()

exports.destroy = (req, res) ->
  _id = req.params.id
  Doc.find({_id: _id}).remove().exec()
  res.end('ok')

