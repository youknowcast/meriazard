// Generated by CoffeeScript 1.8.0
var Utils;

Utils = require('./utils').Utils;

exports.index = function(req, res) {
  return res.render("index", Utils.pageInfo(req));
};
