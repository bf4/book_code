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

app.use(cookieParser());
app.use(session({
    store: new RedisStore({ // specify the usage of RedisStore
        host: 'localhost',
        port: 6379,
        db: 2,
//        pass: 'funky password here', //  specify password
        ttl: (20 * 60) // TTL of 20 minutes represented in seconds
    }),
    name: 'id', // use a generic id
    secret: 'this is a nice secret', // required
    resave: false,
    saveUninitialized: true,
    cookie: {
//        domain: 'secure.example.com', // limit the cookie exposure
//        secure: true, // set the cookie only to be served with HTTPS
        path: '/',
        httpOnly: true,
        maxAge: null
    }
}));

var easySession = require('easy-session');
// Initialize easy session,
// with all the optional options
app.use(easySession.main(session, {
    ipCheck: true,
    uaCheck: true,
    freshTimeout: 5 * 60 * 1000,
    maxFreshTimeout: 10 * 60 * 1000
}));
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
    req.session.logout(function (err) { // Logout
        res.redirect('/');
    });
});

app.get('/secure', easySession.isLoggedIn(), function (req, res, next) {
    res.send('secure');
});

app.get('/secure/more', easySession.isFresh(), function (req, res, next) {
    res.send('You are fresh');
});

app.listen(3000);