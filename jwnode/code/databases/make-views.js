#!/usr/bin/env node --harmony
/***
 * Excerpted from "Node.js the Right Way",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jwnode for more book information.
***/
'use strict';
const
  async = require('async'),
  request = require('request'),
  views = require('./lib/views.js');
async.waterfall([
 
  // get the existing design doc (if present)
  function(next) {
    request.get('http://localhost:5984/books/_design/books', next);
  },
  
  // create a new design doc or use existing
  function(res, body, next) {
    if (res.statusCode === 200) {
      next(null, JSON.parse(body));
    } else if (res.statusCode === 404) {
      next(null, { views: {} });
    }
  },
  
  // add views to document and submit
  function(doc, next) {
    Object.keys(views).forEach(function(name) {
      doc.views[name] = views[name];
    });
    request({
      method: 'PUT',
      url: 'http://localhost:5984/books/_design/books',
      json: doc
    }, next);
  }
], function(err, res, body) {
  if (err) { throw err; }
  console.log(res.statusCode, body);
});

