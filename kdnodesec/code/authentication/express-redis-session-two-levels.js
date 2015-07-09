/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
'use strict';

var express = require('express');
var session = require('express-session');
var RedisStore = require('connect-redis')(session); // Require connect-redis
var cookieParser = require('cookie-parser');
var app = express();

// Extend the Session prototype with some custom functions
// Add a login function
session.Session.prototype.login = function login() {
    // Set a time of login
    this.session._loggedInAt = Date.now();
};
// Add a function to check the logged in status of the user
session.Session.prototype.isLoggedIn = function isLoggedIn() {
    return !!this._loggedInAt;
};
// Add a function to check the freshness of the session
session.Session.prototype.isFresh = function isFresh() {
    // Return true if logged in less then 3 minutes ago
    return (this._loggedInAt && (Date.now() - this._loggedInAt) < (1000 * 60 * 3));
};

app.use(cookieParser());
app.use(session({
    store: new RedisStore({ // specify the usage of RedisStore
        host: 'localhost',
        port: 6379,
        db: 2,
        pass: 'funky password here', //  specify password
        ttl: (20 * 60) // TTL of 20 minutes represented in seconds
    }),
    name: 'id', // use a generic id
    secret: 'this is a nice secret',
    resave: false,
    saveUninitialized: true
}));

app.get('/', function(req, res){
    if(!req.session.views) {
        req.session.views = 0;
    }
    req.session.views++;

    res.send('hello world. ' + req.session.views + ' times so far.');
});

app.get('/login', function (req, res) {
    req.session.login()
    res.send('ok - ' + req.session._loggedInAt);
});


app.get('/secure', function (req, res) {
    if(!req.session.isLoggedIn()) { // Check if user is logged in
        res.send(401);
        return;
    }
    res.send('Access');
});

app.get('/secure/more', function (req, res) {
    if(!req.session.isFresh()) { // Check if session is fresh
        res.send(401);
        return;
    }
    res.send('You are fresh');
});

app.get('/logout', function (req, res) {
    req.session.destroy(); // Delete session
    res.redirect('/');
});

app.listen(3000);