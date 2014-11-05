/***
 * Excerpted from "CoffeeScript: Accelerated JavaScript Development, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tbcoffee2 for more book information.
***/
(function() {
  var Datastore, app, bodyParser, db, env, express, port;

  env = process.env.NODE_ENV || 'development';

  if (env === 'development') {
    require('source-map-support').install();
  }

  express = require('express');

  app = express();

  port = process.env.PORT || 8520;

  app.listen(port);

  console.log("Now listening on port " + port);

  app.use(express["static"]("" + __dirname + "/public"));

  Datastore = require('nedb');

  db = {};

  ['boards', 'columns', 'cards'].forEach((function(_this) {
    return function(collectionKey) {
      db[collectionKey] = new Datastore({
        filename: "" + __dirname + "/" + collectionKey + ".db",
        autoload: true
      });
      db[collectionKey].ensureIndex({
        fieldName: 'id',
        unique: true
      });
    };
  })(this));

  db.boards.insert({
    id: 1,
    name: 'New Board'
  });

  bodyParser = require('body-parser');

  app.use(bodyParser.json());

  ['boards', 'columns', 'cards'].forEach((function(_this) {
    return function(collectionKey) {
      app.get("/" + collectionKey, function(req, res) {
        return db[collectionKey].find({}, function(err, collection) {
          if (err) {
            throw err;
          }
          res.send(collection);
        });
      });
      app.post("/" + collectionKey, function(req, res) {
        var object;
        object = req.body;
        return db[collectionKey].count({}, function(err, count) {
          if (err) {
            throw err;
          }
          object.id = count + 1;
          return db[collectionKey].insert(object, function(err) {
            if (err) {
              throw err;
            }
            res.send(object);
          });
        });
      });
      return app.put("/" + collectionKey + "/:id", function(req, res) {
        var object, options, query;
        query = {
          id: +req.params.id
        };
        object = req.body;
        options = {};
        return db[collectionKey].update(query, object, options, function(err) {
          if (err) {
            throw err;
          }
          res.send(object);
        });
      });
    };
  })(this));

}).call(this);

//# sourceMappingURL=server.js.map
