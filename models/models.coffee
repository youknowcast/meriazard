mongoose = require('mongoose')
db = mongoose.connect('mongodb://localhost/meriazard')

validator = (v) ->
  v.length > 0

# schema を作成
User = new mongoose.Schema
  name: { type: String, validate: [validator, "Empty Error"] }
  user_id: { type: String }
  passwd: { type: String }
  create_at: { type: Date, default: Date.now }
  update_at: { type: Date, default: Date.now }

exports.User = db.model('User', User)