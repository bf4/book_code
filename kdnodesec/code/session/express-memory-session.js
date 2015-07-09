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
var cookieParser = require('cookie-parser');
var app = express();

app.use(cookieParser());
app.use(session({
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

app.listen(3000);