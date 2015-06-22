/***
 * Excerpted from "Deliver Audacious Web Apps with Ember 2",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mwjsember for more book information.
***/
module.exports = function(app) {
  var express = require('express');
  var usersRouter = express.Router();

  // Use the body-parser library in this service
  var bodyParser = require('body-parser');
  app.use(bodyParser.json());

  // Create an embedded table using nedb if it doesn't yet exist
  var nedb = require('nedb');
  var userDB = new nedb({ filename : 'users', autoload: true});

  // The POST url is used to create a new record
  usersRouter.post('/', function(req, res) {

    // Look for the most recently created record and use it to set the id
    // field of our incoming record, which is required by Ember Data
    userDB.find({}).sort({id : -1}).limit(1).exec(function(err,users) {
      var body = req.body;
      if(users.length != 0)
        req.body.user.id = users[0].id + 1;
      else
        req.body.user.id = 1;

      // Insert the new record into our data store, and return the newly 
      // created record to Ember Data
      userDB.insert(req.body.user,function(err,newUser) {
        res.status(201);
        res.send(
          JSON.stringify(
          {
            user : newUser
          }));
      });
    })
  });

  // For now, we won't touch the rest of this code, which was created by
  // Ember CLI
  usersRouter.get('/', function(req, res) {
    res.send({
      'users': []
    });
  });

  usersRouter.get('/:id', function(req, res) {
    res.send({
      'users': {
        id: req.params.id
      }
    });
  });

  usersRouter.put('/:id', function(req, res) {
    res.send({
      'users': {
        id: req.params.id
      }
    });
  });

  usersRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/api/users', usersRouter);
};
