/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

// We will be mocking a database connection in this example
// for the sake of simplicity and control.

// Define our database and functions
var _db = {};

function find(key, cb) {
    setImmediate(cb, null, (db[key] || ''));
}

function save(key, value, cb) {
    db[key] = value;
    setImmediate(cb);
}

var db = {
    find: find,
    save: save
};

//-----

var express = require('express');
var bodyParser = require('body-parser')
var app = express();
app.use(bodyParser.urlencoded({extended: false}));

app.get('/', function(req, res){
    // Search for the file
    db.find('file', function (err, data) {
        if(err) {
            res.send(500);
            return;
        }
        // Send the contents and the form
        res.send('<pre>' + data + '</pre>' +
        '<form method="POST">' +
            '<input name="text" />' +
            '<input type="submit" value="submit" />' +
        '</form>');
    });
});
app.post('/', function (req, res) {
    // Search for the file
    db.find('file', function (err, data) {
        if(err) {
            res.send(500);
            return;
        }


        // Add delay of 5 seconds here
        setTimeout(function () {
            // Append to the file
            data += '\n' + req.body.text;

            // Write the file to db
            db.save('file', data, function (err) {
                if(err) {
                    res.send(500);
                    return;
                }
                res.redirect('/');
            });
        }, 5000);
    });
});

app.listen(3000);