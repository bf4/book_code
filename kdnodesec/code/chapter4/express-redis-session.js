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
var RedisStore = require('connect-redis')(express); // Require connect-redis
var session = require('express-session');
var cookieParser = require('cookie-parser');
var app = express();

session.Session.prototype.login = function login(cb) {
    var req = this.req;
    this.regenerate(function (err) {
        if(err) {
            cb(err);
            return;
        }
        req.session._loggedInAt = Date.now();
        req.session._ip = req.ip;
        req.session._ua = req.headers['user-agent'];
        cb();
    });
};

session.Session.prototype.isGuest = function isGuest() {
    return !this._loggedInAt; // If this is not set then we are not logged in
};

session.Session.prototype.isFresh = function isFresh() {
    // Return true if logged in less then 10 minutes ago
    return (this._loggedInAt && (Date.now() - this._loggedInAt) < (1000 * 60 * 10));
};

app.use(cookieParser());
app.use(session({
    store: new RedisStore({ // specify the usage of RedisStore
        host: 'localhost',
        port: 6379,
        db: 2,
        //pass: 'funky password here', //  specify password
        ttl: (20 * 60) // TTL of 20 minutes represented in seconds
    }),
    name: 'id', // use a generic id
    secret: 'this is a nice secret', // required
    cookie: {
        //domain: 'secure.example.com', // limit the cookie exposure
        //secure: true, // set the cookie only to be served with HTTPS
        path: '/',
        httpOnly: true,
        maxAge: null
    }
}));

// Set cache control header to eliminate cookies from cache
app.use(function (req, res, next) {
    res.header('Cache-Control', 'no-cache="Set-Cookie, Set-Cookie2"');
    next();
});

// Check Session information
app.use(function (req, res, next) {

    if(!req.session) { // If there is no session then something is wrong
        next(new Error('Session object missing'));
        return;
    }

    if(req.session.isGuest()) { // If not logged in then continue
        next();
        return;
    }

    if(req.session._ip !== req.ip) { // Check ip match
        // It would be wise to log more information here
        // to either notify the user or
        // to try and prevent further attacks
        console.warn('The request IP did not match session IP');

        // Generate a new unauthenticated session
        req.session.regenerate(function () {
            next();
        });
        return;
    }

    if(req.session._ua !== req.headers['user-agent']) { // Check UA validity
        // It would be wise to log more information here
        // to either notify the user or
        // to try and prevent further attacks
        console.warn('The request User Agent did not match session user agent');

        // Generate a new unauthenticated session
        req.session.regenerate(function () {
            next();
        });
        return;
    }
    // Everything checks out so continue
    next();
});

app.get('/', function(req, res){
    if(!req.session.views) {
        req.session.views = 0;
    }
    req.session.views++;

    res.send('hello world. ' + req.session.views + ' times so far.');
});

app.get('/login', function (req, res) {
    req.session.login(function(err) {
        res.send('ok - ' + req.session._loggedInAt);
    });
});

app.get('/logout', function (req, res) {
    req.session.destroy(); // Delete session
    res.redirect('/');
});

app.listen(3000);