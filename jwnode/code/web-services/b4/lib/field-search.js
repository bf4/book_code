/***
 * Excerpted from "Node.js the Right Way",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jwnode for more book information.
***/
/**
 * author and subject search
 * curl http://localhost:3000/api/search/author?q=Giles
 * curl http://localhost:3000/api/search/subject?q=Croc
 */
'use strict';
const request = require('request');
module.exports = function(config, app) {  
  app.get('/api/search/:view', function(req, res) {  
    request({  
      method: 'GET',
      url: config.bookdb + '_design/books/_view/by_' + req.params.view,  
      qs: {
        startkey: JSON.stringify(req.query.q),  
        endkey: JSON.stringify(req.query.q + "\ufff0"),
        group: true
      }
    }, function(err, couchRes, body) {  
      
      // couldn't connect to CouchDB
      if (err) {
        res.json(502, { error: "bad_gateway", reason: err.code });
        return;
      }
      
      // CouchDB couldn't process our request
      if (couchRes.statusCode !== 200) {
        res.json(couchRes.statusCode, JSON.parse(body));
        return;
      }
      
      // send back just the keys we got back from CouchDB
      res.json(JSON.parse(body).rows.map(function(elem){
        return elem.key;
      }));
      
    });
  });
};
