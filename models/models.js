// Generated by CoffeeScript 1.3.3
var User, db, mongoose, validator;

mongoose = require('mongoose');

db = mongoose.connect('mongodb://localhost/meriazard');

validator = function(v) {
  return v.length > 0;
};

User = new mongoose.Schema({
  name: {
    type: String,
    validate: [validator, "Empty Error"]
  },
  user_id: {
    type: String
  },
  passwd: {
    type: String
  },
  create_at: {
    type: Date,
    "default": Date.now
  },
  update_at: {
    type: Date,
    "default": Date.now
  }
});

exports.User = db.model('User', User);
