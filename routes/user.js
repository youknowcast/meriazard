// Generated by CoffeeScript 1.8.0
var Doc, FILE_PREFIX, LOGIN_KEYS, User, Utils, checksum, crypto, fs, models, mongoose, _;

fs = require('fs');

mongoose = require('mongoose');

_ = require('underscore');

crypto = require('crypto');

models = require('../models/models');

Utils = require('./utils').Utils;

User = models.User;

Doc = models.Doc;

LOGIN_KEYS = ["input_id", "input_passwd"];

FILE_PREFIX = './files/F_';

exports.login = function(req, res) {
  var _params;
  _params = req.body || {};
  if (!Utils.checkParams(_params, LOGIN_KEYS)) {
    res.redirect('/');
  }
  return User.find({
    user_id: _params.input_id
  }, function(err, docs) {
    var dbPass, queryPass, user;
    if (docs.length === 1) {
      user = docs[0];
      dbPass = Utils.getCrypto(user.passwd);
      queryPass = Utils.getCrypto(_params.input_passwd);
      if (dbPass === queryPass) {
        res.redirect('/list');
        return;
      }
    }
    return res.redirect('/');
  });
};

exports.list = function(req, res) {
  return res.render("list", Utils.pageInfo(req));
};

exports.search = function(req, res) {
  var _data, _i;
  res.contentType('application/json');
  _data = [];
  _i = 0;
  return Doc.find({}, function(err, docs) {
    _.each(docs, function(d) {
      _i += 1;
      return _data.push({
        no: _i,
        doc_id: d._id,
        filename: d.name,
        size: d.size,
        content_type: d.content_type,
        created: Utils.dateFormat(d.create_at)
      });
    });
    return res.send(_data);
  });
};

exports.searchQuery = function(req, res) {
  var _data, _i, _query;
  res.contentType('application/json');
  _query = {
    name: req.params.query
  };
  _data = [];
  _i = 0;
  return Doc.find(_query, function(err, docs) {
    _.each(docs, function(d) {
      _i += 1;
      return _data.push({
        no: _i,
        doc_id: d._id,
        filename: d.name,
        size: d.size,
        content_type: d.content_type,
        created: Utils.dateFormat(d.create_at)
      });
    });
    return res.send(_data);
  });
};

checksum = function(str) {
  return crypto.createHash('md5').update(str, 'binary').digest('hex');
};

exports.upload = function(req, res) {
  var doc, file, filePath;
  file = req.files.register_input;
  filePath = FILE_PREFIX + checksum(fs.readFileSync(file.path));
  fs.rename(file.path, filePath, function(err) {
    throw err;
  });
  doc = new Doc;
  doc.name = file.name;
  doc.size = file.size;
  doc.path = filePath;
  doc.content_type = file.headers["content-type"];
  return doc.create_at = new Date(doc.save(function(e) {
    if (e) {
      console.log('error' + e);
    }
    return res.render('async_load');
  }));
};

exports.download = function(req, res) {
  var _id;
  _id = req.params.doc_id;
  return Doc.find({
    _id: _id
  }, function(err, docs) {
    var _file;
    if (err) {
      return res.send("");
    } else {
      _file = docs[0];
      res.setHeader('Content-disposition', 'attachment; filename*=UTF-8\'\'' + encodeURIComponent(_file.name));
      res.setHeader('Content-type', _file.content_type);
      res.setHeader('Content-Length', _file.size);
      res.write(fs.readFileSync(_file.path), 'binary');
      return res.end();
    }
  });
};

exports.destroy = function(req, res) {
  var _id;
  _id = req.params.id;
  Doc.find({
    _id: _id
  }).remove().exec();
  return res.end('ok');
};
