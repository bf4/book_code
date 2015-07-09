/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

var mysql = require('mysql');
var express = require('express');
var cookieParser = require('cookie-parser');
var args = require('minimist')(process.argv);

if(!args.d || !args.ap || !args.au || !args.gu || !args.gp) {
    console.log('This example requires the -d (mysql db), ' +
    '-au (admin user), -ap (admin password) ' +
    '-gu (guest user), -gp (guest password) command line variables');
    process.exit();
}

var app = express();

app.use(cookieParser());
var session = require('express-session');
app.use(session({
    secret: 'this is a nice secret',
    resave: false,
    saveUninitialized: true
}));

// Set up guest connection
var guestConnection = mysql.createConnection({
    host     : 'localhost',
    user     : args.gu,
    database : args.d,
    password : args.gp
});
guestConnection.connect();

// Set up admin connection
var adminConnection = mysql.createConnection({
    host     : 'localhost',
    user     : args.au,
    database : args.d,
    password : args.ap
});
adminConnection.connect();

// Middleware for checking the logged in status
app.use(function (req, res, next) {
    // If we have an admin session then attach adminConnection
    if(req.session && req.session.isAdmin) {
        req.db = adminConnection;
    }
    // Otherwise attach guestConnection
    else {
        req.db = guestConnection;
    }
    next();
});

app.get('/', function (req, res) {
    res.send('ok');
});

app.get('/:name', function(req, res, next){

    // Query the account based on url parameters
    req.db.query('SELECT * FROM accounts WHERE name="' + req.params.name + '"', function(err, rows, fields) {
        if (err) {
            next(err);
            return;
        }
        res.send(JSON.stringify(rows));
    });
});

app.listen(3000);
