mongoose = require('mongoose')
db = mongoose.connect('mongodb://localhost/meriazard')

validator = (v) ->
  v.length > 0

# schema を作成
User = new mongoose.Schema
  name: { type: String, validate: [validator, "Empty Error"] }
  user_id:
    type: String 
    index: { unique: true }
  passwd: { type: String }
  create_at: { type: Date, default: Date.now }

# 作者情報
Author = new mongoose.Schema
  names: [String]
  show_name: String

# 作品傾向
Type = new mongoose.Schema
  name: [String]
  refs: [Type]
  comment: String

Doc = new mongoose.Schema
  name: { type: String, validate: [validator, "Empty Error"] }
  size: { type: String }
  path: { type: String }
  attributes: 
    type:  { type: [Type] }
    author: {type: [Author]}
  content_type: { type: String }
  create_at: { type: Date, default: Date.now }

exports.User = db.model('User', User)
exports.Doc = db.model('Doc', Doc)

