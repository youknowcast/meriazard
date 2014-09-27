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

Doc = new mongoose.Schema
  name: { type: String, validate: [validator, "Empty Error"] }
  size: { type: String }
  path: { type: String }
  attributes: 
    type:  { type: String }
  content_type: { type: String }
  create_at: { type: Date, default: Date.now }

exports.User = db.model('User', User)
exports.Doc = db.model('Doc', Doc)

